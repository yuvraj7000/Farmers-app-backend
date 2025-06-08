import pool from "../utils/database_connection.js";
import admin from "../utils/firebase.js";

// Add FCM token
const addFcmToken = async (req, res) => {
  try {
    const { fcm_token, district, language = 'en' } = req.body;

    if (!fcm_token) {
      return res.status(400).json({ error: "FCM token is required" });
    }

    const query = `
      INSERT INTO user_fcm_tokens (fcm_token, district, language) 
      VALUES ($1, $2, $3) 
      ON CONFLICT (fcm_token) 
      DO UPDATE SET district = EXCLUDED.district, language = EXCLUDED.language, updated_at = CURRENT_TIMESTAMP 
      RETURNING *;
    `;

    const result = await pool.query(query, [fcm_token, district || null, language || 'en']);

    res.status(201).json({
      message: "FCM token added successfully",
      token: result.rows[0],
    });
  } catch (err) {
    console.error("Error adding FCM token:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

// Delete FCM token
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

// Get all FCM tokens
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

// Send push notification using FCM tokens
const sendPushNotification = async (req, res) => {
  try {
    const { title, message, district = 'all', language = 'en' } = req.body;

    if (!title || !message) {
      return res.status(400).json({ error: "Title and message are required" });
    }

    let tokenQuery = `
      SELECT fcm_token FROM user_fcm_tokens
      WHERE language = $1
    `;
    let queryParams = [language];

    if (district !== 'all') {
      tokenQuery += ` AND district = $2`;
      queryParams.push(district);
    }

    const tokenResult = await pool.query(tokenQuery, queryParams);

    if (tokenResult.rows.length === 0) {
      return res.status(404).json({ error: "No matching FCM tokens found" });
    }

    const tokens = tokenResult.rows.map(row => row.fcm_token);

    // Prepare the notification payload
    const BATCH_SIZE = 500;
    let responses = [];
    for (let i = 0; i < tokens.length; i += BATCH_SIZE) {
      const batch = tokens.slice(i, i + BATCH_SIZE);
      const multicastMessage = {
        tokens: batch,
        notification: {
          title,
          body: message,
        },
        data: {
          message,
        },
      };
      const response = await admin.messaging().sendEachForMulticast(multicastMessage);
      responses.push(response);
    }

    res.status(200).json({
      message: "Push notifications sent successfully",
      responses,
    });

  } catch (err) {
    console.error("Error sending push notification:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

export { addFcmToken, deleteFcmToken, getAllFcmTokens, sendPushNotification };