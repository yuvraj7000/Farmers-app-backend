import pool from "../utils/database_connection.js";
import { Expo } from "expo-server-sdk";

const addFcmToken = async (req, res) => {
    try {
      const { fcm_token, district } = req.body;
  
      if (!fcm_token) {
        return res.status(400).json({ error: "FCM token is required" });
      }
  
      const query = `
        INSERT INTO user_fcm_tokens (fcm_token, district) 
        VALUES ($1, $2) 
        ON CONFLICT (fcm_token) 
        DO UPDATE SET district = EXCLUDED.district, updated_at = CURRENT_TIMESTAMP 
        RETURNING *;
      `;
  
      const result = await pool.query(query, [fcm_token, district || null]);
  
      res.status(201).json({
        message: "FCM token added successfully",
        token: result.rows[0],
      });
    } catch (err) {
      console.error("Error adding FCM token:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };

  const deleteFcmToken = async (req, res) => {
    try {
      const { fcm_token } = req.body;
  
      if (!fcm_token) {
        return res.status(400).json({ error: "FCM token is required" });
      }
  
      const query = `DELETE FROM user_fcm_tokens WHERE fcm_token = $1 RETURNING *;`;
      const result = await pool.query(query, [fcm_token]);
  
      if (result.rowCount === 0) {
        return res.status(404).json({ error: "FCM token not found" });
      }
  
      res.status(200).json({
        message: "FCM token deleted successfully",
        deletedToken: result.rows[0],
      });
    } catch (err) {
      console.error("Error deleting FCM token:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };


  const getAllFcmTokens = async (req, res) => {
    try {
      const query = `SELECT * FROM user_fcm_tokens ORDER BY created_at DESC;`;
      const result = await pool.query(query);
  
      res.status(200).json({
        message: "FCM tokens retrieved successfully",
        tokens: result.rows,
      });
    } catch (err) {
      console.error("Error retrieving FCM tokens:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };

  const sendPushNotification = async (req, res) => {
    try {
      // 1️⃣ Get the notification title & body from the request
      const { title, message } = req.body;
  
      if (!title || !message) {
        return res.status(400).json({ error: "Title and message are required" });
      }
  
      // 2️⃣ Fetch all FCM tokens from the database
      const tokenQuery = `SELECT fcm_token FROM user_fcm_tokens;`;
      const tokenResult = await pool.query(tokenQuery);
      
      if (tokenResult.rows.length === 0) {
        return res.status(404).json({ error: "No FCM tokens found" });
      }
  
      // 3️⃣ Extract FCM tokens
      const tokens = tokenResult.rows.map(row => row.fcm_token);
  
      // 4️⃣ Initialize Expo SDK
      let expo = new Expo();
  
      // 5️⃣ Create notification messages
      let messages = [];
      for (let token of tokens) {
        if (!Expo.isExpoPushToken(token)) {
          console.warn(`Invalid token: ${token}`);
          continue;
        }
  
        messages.push({
          to: token,
          sound: "default",
          title: title,
          body: message,
          data: { message },
        });
      }
  
      // 6️⃣ Send notifications in chunks
      let chunks = expo.chunkPushNotifications(messages);
      let tickets = [];
      
      for (let chunk of chunks) {
        let ticketChunk = await expo.sendPushNotificationsAsync(chunk);
        tickets.push(...ticketChunk);
      }
  
      res.status(200).json({
        message: "Push notifications sent successfully",
        tickets,
      });
    } catch (err) {
      console.error("Error sending push notification:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };

  export { addFcmToken, deleteFcmToken, getAllFcmTokens, sendPushNotification };