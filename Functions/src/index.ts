import { setGlobalOptions } from "firebase-functions/v2/options";
import { onDocumentCreated } from "firebase-functions/v2/firestore";
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
    const chatRoomId = event.params.room;

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
      logger.error("Supabase query failed (preferences):", prefsError);
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
        room_id: chatRoomId,
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
