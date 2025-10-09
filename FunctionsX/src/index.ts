import { setGlobalOptions } from "firebase-functions/v2/options";
import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { defineSecret } from "firebase-functions/params";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";
import { createClient } from "@supabase/supabase-js";

admin.initializeApp();

const SUPABASE_URL = defineSecret("SUPABASE_URL");
const SUPABASE_KEY = defineSecret("SUPABASE_KEY");

// Limit max instances to control costs
setGlobalOptions({
  maxInstances: 10,
  secrets: [SUPABASE_URL, SUPABASE_KEY],
});

function getSupabaseClient() {
  return createClient(SUPABASE_URL.value(), SUPABASE_KEY.value());
}

// Example function (can be removed if not used)
// export const helloWorld = onRequest((req, res) => {
//   logger.info("Hello logs!", { structuredData: true });
//   res.send("Hello from Firebase!");
// });

// Trigger: runs when a new message document is created
export const sendChatNotification = onDocumentCreated(
  "chats/{room_id}/messages/{message_id}",
  async (event) => {
    const message = event.data?.data();
    const chatRoomId = event.params.room_id;

    if (!message) {
      logger.warn("Empty message, skipping notification");
      return;
    }

    const recipientId = message.recipient_id;
    if (!recipientId) {
      logger.warn("No recipientId found in message");
      return;
    }

    // Supabase client
    const supabase = getSupabaseClient();

    // Query Supabase to get the device token
    const { data: user, error } = await supabase
      .from("app_user")
      .select("device_token")
      .eq("id", recipientId)
      .single();

    if (error) {
      logger.error("Supabase query failed", error);
      return;
    }

    if (!user?.device_token) {
      logger.info("User does not have a device_token");
      return;
    }

    const payload: admin.messaging.Message = {
      notification: {
        title: "Te enviaron un mensaje nuevo",
        body: message.text,
      },
      data: {
        chat_room_id: chatRoomId,
      },
      token: user.device_token,
    };

    try {
      await admin.messaging().send(payload);
      logger.info(`Notification sent to user ${recipientId}`);
    } catch (err) {
      logger.error("Error sending notification", err);
    }
  }
);
