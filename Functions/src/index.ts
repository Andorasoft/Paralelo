import { setGlobalOptions } from "firebase-functions/v2/options";
import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { onRequest } from "firebase-functions/v2/https";
import { getFirestore } from "firebase-admin/firestore";
import { defineSecret } from "firebase-functions/params";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";
import { createClient } from "@supabase/supabase-js";

// -----------------------------------------------------------
// 🔧 Initialization
// -----------------------------------------------------------

/**
 * Initializes the Firebase Admin SDK for FCM and Firestore.
 */
admin.initializeApp();

/**
 * Define Supabase credentials as Firebase secrets.
 * These values are securely injected at runtime.
 */
const SUPABASE_URL = defineSecret("SUPABASE_URL");
const SUPABASE_KEY = defineSecret("SUPABASE_KEY");

/**
 * Limit Cloud Function concurrency to control billing
 * and register required runtime secrets.
 */
setGlobalOptions({
  maxInstances: 10,
  secrets: [SUPABASE_URL, SUPABASE_KEY],
});

// -----------------------------------------------------------
// 🧩 Supabase Client Helper
// -----------------------------------------------------------

/**
 * Returns a Supabase client using the injected secret credentials.
 * Called per-execution for isolation and simplicity.
 */
function getSupabaseClient() {
  return createClient(SUPABASE_URL.value(), SUPABASE_KEY.value());
}

// -----------------------------------------------------------
// 📬 Cloud Function: sendChatNotification
// -----------------------------------------------------------

/**
 * Triggered when a new message document is created under:
 *   rooms/{room}/messages/{message}
 *
 * Workflow:
 *  1. Validate message data and recipient.
 *  2. Query Supabase for the recipient’s device token.
 *  3. Check if notifications are enabled.
 *  4. Send an FCM push notification via Firebase Admin SDK.
 */
export const sendChatNotification = onDocumentCreated(
  "rooms/{room}/messages/{message}",
  async (event) => {
    // Extract message payload and room ID from Firestore
    const message = event.data?.data();
    const roomId = event.params.room;

    // --- Step 1: Validate incoming message ---
    if (!message) {
      logger.warn("Empty message document. Skipping notification.");
      return;
    }

    const recipientId = message.recipient;
    const text = (message.text || "").trim();

    if (!recipientId) {
      logger.warn("Message missing 'recipient' field.");
      return;
    }

    logger.log(`Recipient: ${recipientId}`);

    if (!text) {
      logger.info("Message contains no text. Notification skipped.");
      return;
    }

    // --- Step 2: Initialize Supabase client ---
    const supabase = getSupabaseClient();

    // --- Step 3: Fetch user device token from Supabase ---
    const { data: user, error: userError } = await supabase
      .from("user")
      .select("device_token")
      .eq("id", recipientId)
      .single();

    if (userError) {
      logger.error("Supabase query failed (user):", userError);
      return;
    }

    if (!user?.device_token) {
      logger.info(`User ${recipientId} has no device_token.`);
      return;
    }

    // --- Step 4: Fetch notification preferences ---
    const { data: prefs, error: prefsError } = await supabase
      .from("user_preference")
      .select("notifications_enabled, language")
      .eq("user_id", recipientId)
      .single();

    if (prefsError) {
      logger.error("Supabase query failed (preferences):", prefsError.message);
      return;
    }

    if (!prefs?.notifications_enabled) {
      logger.info(`User ${recipientId} has notifications disabled.`);
      return;
    }

    // --- Optional: basic localization ---
    const title =
      prefs.language === "en"
        ? "You have a new message"
        : "Te enviaron un mensaje nuevo";

    // --- Step 5: Build the FCM notification payload ---
    const payload: admin.messaging.Message = {
      notification: {
        title,
        body: text.length > 120 ? text.substring(0, 117) + "..." : text,
      },
      data: {
        room_id: roomId,
      },
      token: user.device_token,
    };

    // --- Step 6: Send the FCM notification ---
    try {
      await admin.messaging().send(payload);
      logger.info(`✅ Notification sent to user ${recipientId}`);
    } catch (err) {
      logger.error("❌ Error sending FCM notification:", err);
    }
  }
);

/**
 * Cloud Function: cleanupRooms
 * ------------------------------------------------------------
 * Deletes multiple chat rooms from Firestore in parallel.
 * For each room:
 *  - Deletes all messages in sub-collection "messages"
 *    in safe batches of 500 writes (Firestore limit).
 *  - Deletes the parent room document.
 *
 * Expected request body:
 *   { "rooms": [{ "id": "room123" }, { "id": "room456" }] }
 *
 * Returns:
 *   200 OK  → All deletions completed successfully
 *   400     → Missing or invalid input
 *   500     → Internal server error
 */
export const cleanupRooms = onRequest(async (req, res): Promise<any> => {
  try {
    const firestore = getFirestore();
    const { rooms } = req.body as { rooms: { id: string }[] };

    // Validate input
    if (!rooms || !Array.isArray(rooms) || rooms.length === 0) {
      return res.status(400).send("No rooms provided.");
    }

    // Run deletions for all rooms in parallel
    await Promise.all(
      rooms.map(async (room) => {
        const roomRef = firestore.collection("rooms").doc(room.id);
        const messagesRef = roomRef.collection("messages");

        // 🔁 Delete messages in batches of up to 500
        while (true) {
          const snapshot = await messagesRef.limit(500).get();
          if (snapshot.empty) break;

          const batch = firestore.batch();
          snapshot.docs.forEach((doc) => batch.delete(doc.ref));
          await batch.commit();
        }

        // 🗑️ Delete the room document itself
        await roomRef.delete();
        console.log(`✅ Room ${room.id} deleted.`);
      })
    );

    // ✅ Success response
    return res.status(200).send();
  } catch (err: any) {
    console.error("❌ cleanupRooms error:", err);
    return res.status(500).send(err.message);
  }
});
