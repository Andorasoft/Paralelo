import { setGlobalOptions } from "firebase-functions/v2/options";
import { onDocumentCreated } from "firebase-functions/v2/firestore";
import * as logger from "firebase-functions/logger";
import * as admin from "firebase-admin";
import { createClient } from "@supabase/supabase-js";

admin.initializeApp();

// Limit max instances to control costs
setGlobalOptions({ maxInstances: 10 });

// Supabase client (values must be set in Firebase environment config)
const supabase = createClient(
  process.env.SUPABASE_URL as string,
  process.env.SUPABASE_KEY as string
);

// Example function (can be removed if not used)
// export const helloWorld = onRequest((req, res) => {
//   logger.info("Hello logs!", { structuredData: true });
//   res.send("Hello from Firebase!");
// });

// Trigger: runs when a new message document is created
export const sendChatNotification = onDocumentCreated(
  "chats/{chatRoomId}/messages/{messageId}",
  async (event) => {
    const message = event.data?.data();
    const chatRoomId = event.params.chatRoomId;

    if (!message) {
      logger.warn("Empty message, skipping notification");
      return;
    }

    const recipientId = message.recipientId;
    if (!recipientId) {
      logger.warn("No recipientId found in message");
      return;
    }

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
        title: "New message",
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
