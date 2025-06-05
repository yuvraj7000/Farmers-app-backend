import pool from "../utils/database_connection.js";

// Get all news by language
export const getAllNews = async (req, res) => {
  try {
    const { language_code, page = 1, limit = 10 } = req.body;

    if (!language_code) {
      return res.status(400).json({ error: "language_code is required" });
    }

    const offset = (page - 1) * limit;

    const query = `
      SELECT * FROM news
      WHERE language_code = $1
      ORDER BY date DESC
      LIMIT $2 OFFSET $3
    `;

    const result = await pool.query(query, [language_code, limit, offset]);

    const countQuery = `
      SELECT COUNT(*) FROM news WHERE language_code = $1
    `;
    const countResult = await pool.query(countQuery, [language_code]);
    const totalCount = parseInt(countResult.rows[0].count);

    res.status(200).json({
      page: parseInt(page),
      limit: parseInt(limit),
      total: totalCount,
      count: result.rows.length,
      news: result.rows,
    });
  } catch (err) {
    console.error("Error fetching news:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

// Add new news item
export const addNews = async (req, res) => {
  try {
    const {
      date,
      image_url,
      source,
      language_code,
      title,
      content,
      youtube_url, // Added youtube_url
    } = req.body;

    if (!language_code || !title || !content) {
      return res.status(400).json({ error: "language_code, title and content are required" });
    }

    const query = `
      INSERT INTO news (date, image_url, source, language_code, title, content, youtube_url)
      VALUES (COALESCE($1, CURRENT_DATE), $2, $3, $4, $5, $6, $7)
      RETURNING *
    `;

    const values = [date, image_url, source, language_code, title, content, youtube_url];

    const result = await pool.query(query, values);

    res.status(201).json({ message: "News added successfully", news: result.rows[0] });
  } catch (err) {
    console.error("Error adding news:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

// Update news by ID
export const updateNews = async (req, res) => {
  try {
    const { id, date, image_url, source, language_code, title, content, youtube_url } = req.body;

    if (!id) {
      return res.status(400).json({ error: "News id is required for update" });
    }

    // Update query - only update provided fields
    const query = `
      UPDATE news
      SET
        date = COALESCE($2, date),
        image_url = COALESCE($3, image_url),
        source = COALESCE($4, source),
        language_code = COALESCE($5, language_code),
        title = COALESCE($6, title),
        content = COALESCE($7, content),
        youtube_url = COALESCE($8, youtube_url),
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $1
      RETURNING *
    `;

    const values = [id, date, image_url, source, language_code, title, content, youtube_url];

    const result = await pool.query(query, values);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "News not found" });
    }

    res.status(200).json({ message: "News updated successfully", news: result.rows[0] });
  } catch (err) {
    console.error("Error updating news:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

// Delete news by ID
export const deleteNews = async (req, res) => {
  try {
    const { id } = req.body;

    if (!id) {
      return res.status(400).json({ error: "News id is required to delete" });
    }

    const query = `DELETE FROM news WHERE id = $1 RETURNING *`;

    const result = await pool.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "News not found" });
    }

    res.status(200).json({ message: "News deleted successfully", news: result.rows[0] });
  } catch (err) {
    console.error("Error deleting news:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};