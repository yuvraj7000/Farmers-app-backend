import pool from "../utils/database_connection.js";

const addCrop = async (req, res) => {
    try {
      const { name, image_url, paragraphs } = req.body;
  
      if (!name || !paragraphs || !Array.isArray(paragraphs)) {
        return res.status(400).json({ error: "name and paragraphs are required" });
      }
  
      // Insert crop into database
      const cropQuery = `INSERT INTO crops (name, image_url) VALUES ($1, $2) RETURNING id`;
      const cropResult = await pool.query(cropQuery, [name, image_url]);
      const cropId = cropResult.rows[0].id;
  
      // Insert paragraphs
      const paragraphQuery = `
        INSERT INTO crop_paragraphs (crop_id, language_code, paragraph_title, paragraph_content) 
        VALUES ($1, $2, $3, $4)
      `;
  
      for (const paragraph of paragraphs) {
        await pool.query(paragraphQuery, [
          cropId,
          paragraph.language_code,
          paragraph.paragraph_title,
          paragraph.paragraph_content
        ]);
      }
  
      res.status(201).json({ message: "Crop added successfully", crop_id: cropId });
    } catch (err) {
      console.error("Error adding crop:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };


  const getCropDetails = async (req, res) => {
    try {
      const { name, language_code } = req.body;
  
      if (!name || !language_code) {
        return res.status(400).json({ error: "name and language_code are required" });
      }
  
      // Fetch crop details
      const cropQuery = `SELECT id, name, image_url FROM crops WHERE name = $1`;
      const cropResult = await pool.query(cropQuery, [name]);
  
      if (cropResult.rows.length === 0) {
        return res.status(404).json({ error: "Crop not found" });
      }
  
      const crop = cropResult.rows[0];
  
      // Fetch paragraphs for the crop in the requested language
      const paragraphQuery = `
        SELECT paragraph_title, paragraph_content 
        FROM crop_paragraphs 
        WHERE crop_id = $1 AND language_code = $2
      `;
      const paragraphResult = await pool.query(paragraphQuery, [crop.id, language_code]);
  
      crop.paragraphs = paragraphResult.rows;
  
      res.status(200).json({ crop });
    } catch (err) {
      console.error("Error fetching crop details:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };
  

  const deleteCrop = async (req, res) => {
    try {
      const { name } = req.body;
  
      if (!name) {
        return res.status(400).json({ error: "Crop name is required" });
      }
  
      // Check if the crop exists
      const cropQuery = `SELECT id FROM crops WHERE name = $1`;
      const cropResult = await pool.query(cropQuery, [name]);
  
      if (cropResult.rows.length === 0) {
        return res.status(404).json({ error: "Crop not found" });
      }
  
      const cropId = cropResult.rows[0].id;
  
      // Delete crop paragraphs first (CASCADE handles this, but explicitly deleting for clarity)
      await pool.query(`DELETE FROM crop_paragraphs WHERE crop_id = $1`, [cropId]);
  
      // Delete the crop
      await pool.query(`DELETE FROM crops WHERE id = $1`, [cropId]);
  
      res.status(200).json({ message: "Crop deleted successfully" });
    } catch (err) {
      console.error("Error deleting crop:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };
  
  const updateCropPara = async (req, res) => {
    try {
      const { crop_name, paragraph_title, language_code, new_title, new_text } = req.body;
  
      if (!crop_name || !paragraph_title || !language_code || !new_text || !new_title) {
        return res.status(400).json({ error: "All fields are required" });
      }
  
      // Get the crop ID
      const cropQuery = `SELECT id FROM crops WHERE name = $1`;
      const cropResult = await pool.query(cropQuery, [crop_name]);
  
      if (cropResult.rows.length === 0) {
        return res.status(404).json({ error: "Crop not found" });
      }
  
      const cropId = cropResult.rows[0].id;
  
      // Update paragraph
      const updateQuery = `
        UPDATE crop_paragraphs
        SET paragraph_content = $1, paragraph_title = $5
        WHERE crop_id = $2 AND paragraph_title = $3 AND language_code = $4
      `;
  
      const updateResult = await pool.query(updateQuery, [new_text, cropId, paragraph_title, language_code, new_title]);
  
      if (updateResult.rowCount === 0) {
        return res.status(404).json({ error: "Paragraph not found" });
      }
  
      res.status(200).json({ message: "Paragraph updated successfully" });
    } catch (err) {
      console.error("Error updating paragraph:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };


  const deleteCropPara = async (req, res) => {
    try {
      const { crop_name, paragraph_title, language_code } = req.body;
  
      if (!crop_name || !paragraph_title || !language_code) {
        return res.status(400).json({ error: "All fields are required" });
      }
  
      // Get the crop ID
      const cropQuery = `SELECT id FROM crops WHERE name = $1`;
      const cropResult = await pool.query(cropQuery, [crop_name]);
  
      if (cropResult.rows.length === 0) {
        return res.status(404).json({ error: "Crop not found" });
      }
  
      const cropId = cropResult.rows[0].id;
  
      // Delete paragraph
      const deleteQuery = `
        DELETE FROM crop_paragraphs
        WHERE crop_id = $1 AND paragraph_title = $2 AND language_code = $3
      `;
  
      const deleteResult = await pool.query(deleteQuery, [cropId, paragraph_title, language_code]);
  
      if (deleteResult.rowCount === 0) {
        return res.status(404).json({ error: "Paragraph not found" });
      }
  
      res.status(200).json({ message: "Paragraph deleted successfully" });
    } catch (err) {
      console.error("Error deleting paragraph:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };


  const updateCrop = async (req, res) => {
    try {
      const { old_name, new_name, image_url } = req.body;
  
      if (!old_name || !new_name) {
        return res.status(400).json({ error: "Both old_name and new_name are required" });
      }
  
      // Check if the crop exists
      const cropQuery = `SELECT id FROM crops WHERE name = $1`;
      const cropResult = await pool.query(cropQuery, [old_name]);
  
      if (cropResult.rows.length === 0) {
        return res.status(404).json({ error: "Crop not found" });
      }
  
      // Update crop name and image (if provided)
      const updateQuery = `
        UPDATE crops 
        SET name = $1, image_url = COALESCE($2, image_url) 
        WHERE name = $3
      `;
  
      await pool.query(updateQuery, [new_name, image_url || null, old_name]);
  
      res.status(200).json({ message: "Crop updated successfully" });
    } catch (err) {
      console.error("Error updating crop:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };

  const addCropPara = async (req, res) => {
    try {
      const { crop_name, language_code, para_name, content } = req.body;
  
      if (!crop_name || !language_code || !para_name || !content) {
        return res.status(400).json({ error: "All fields are required: crop_name, language_code, para_name, content" });
      }
  
      // Check if the crop exists
      const cropQuery = `SELECT id FROM crops WHERE name = $1`;
      const cropResult = await pool.query(cropQuery, [crop_name]);
  
      if (cropResult.rows.length === 0) {
        return res.status(404).json({ error: "Crop not found" });
      }
  
      const crop_id = cropResult.rows[0].id;
  
      // Insert new paragraph for the crop
      const insertQuery = `
        INSERT INTO crop_paragraphs (crop_id, language_code, paragraph_title, paragraph_content) 
        VALUES ($1, $2, $3, $4)
      `;
  
      await pool.query(insertQuery, [crop_id, language_code, para_name, content]);
  
      res.status(201).json({ message: "Paragraph added successfully" });
    } catch (err) {
      console.error("Error adding paragraph:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };
  


export { addCrop , getCropDetails, deleteCrop,updateCropPara,deleteCropPara,updateCrop,addCropPara};