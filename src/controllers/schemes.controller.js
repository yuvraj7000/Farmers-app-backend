import pool from "../utils/database_connection.js";

const getstateSchemes = async (req, res) => {
  try{
    const{language_code, state} = req.body;
    if(!language_code || !state){
      return res.status(400).json({error: "language_code and state are required"});
    }

    const query =`
        SELECT s.id, s.type, s.gov_level, s.state_or_org, s.start_date, s.end_date, s.status, 
               s.official_link, s.funding_amount, s.image_url, 
               t.name, t.description, t.benefits, t.eligibility, t.application_process
        FROM schemes_subsidies s
        INNER JOIN scheme_translations t ON s.id = t.scheme_id AND t.language_code = $1
        WHERE (s.state_or_org = $2)
        ORDER BY s.start_date DESC
      `;

      const result = await pool.query(query, [language_code, state]);

       // 📌 Fix JSON parsing issue
       const parseJSON = (data) => {
        if (!data) return []; // Return an empty array if data is null
        if (typeof data === "string") {
          try {
            return JSON.parse(data);
          } catch (e) {
            console.error("Invalid JSON:", data);
            return [];
          }
        }
        return data; // If it's already an object, return as is
      };
  
      const schemes = result.rows.map((row) => ({
        id: row.id,
        type: row.type,
        gov_level: row.gov_level,
        state_or_org: row.state_or_org,
        start_date: row.start_date,
        end_date: row.end_date,
        status: row.status,
        official_link: row.official_link,
        funding_amount: row.funding_amount,
        image_url: row.image_url,
        name: row.name,
        description: row.description,
        benefits: parseJSON(row.benefits),
        eligibility: parseJSON(row.eligibility),
        application_process: parseJSON(row.application_process),
      }));
  
      res.status(200).json({ count: schemes.length, schemes });
  }
  catch(err){
    console.error("Error fetching schemes:", err);
    res.status(500).json({ error: "Internal server error" });
  }
}
const getTranslationSchemes = async (req, res) => {
  try{
    const{schemeId} = req.body;
    if(!schemeId){
      return res.status(400).json({error: "schemeId is required"});

    }

    const query =`
        SELECT *
        FROM scheme_translations t
        WHERE ( t.scheme_id= $1)
      `;

      const result = await pool.query(query, [schemeId]);

       // 📌 Fix JSON parsing issue
       const parseJSON = (data) => {
        if (!data) return []; // Return an empty array if data is null
        if (typeof data === "string") {
          try {
            return JSON.parse(data);
          } catch (e) {
            console.error("Invalid JSON:", data);
            return [];
          }
        }
        return data; // If it's already an object, return as is
      };
  
      const schemes = result.rows.map((row) => ({
        id: row.id,
        type: row.type,
        gov_level: row.gov_level,
        state_or_org: row.state_or_org,
        start_date: row.start_date,
        end_date: row.end_date,
        status: row.status,
        official_link: row.official_link,
        funding_amount: row.funding_amount,
        image_url: row.image_url,
        name: row.name,
        language_code: row.language_code,
        description: row.description,
        benefits: parseJSON(row.benefits),
        eligibility: parseJSON(row.eligibility),
        application_process: parseJSON(row.application_process),
      }));
  
      res.status(200).json({ count: schemes.length, schemes });
  }
  catch(err){
    console.error("Error fetching schemes:", err);
    res.status(500).json({ error: "Internal server error" });
  }
}

const getallSchemes = async (req, res) => {
    try {
      let { language_code, search, limit, offset } = req.body;
  
      // Default values for pagination
      limit = limit ? parseInt(limit) : 10;
      offset = offset ? parseInt(offset) : 0;
  
      if (!language_code) {
        return res.status(400).json({ error: "language_code is required" });
      }
  
      // 📌 Query to fetch schemes with translations
      const query = `
        SELECT s.id, s.type, s.gov_level, s.state_or_org, s.start_date, s.end_date, s.status, 
               s.official_link, s.funding_amount, s.image_url, 
               t.name, t.description, t.benefits, t.eligibility, t.application_process
        FROM schemes_subsidies s
        INNER JOIN scheme_translations t ON s.id = t.scheme_id AND t.language_code = $1
        WHERE ($2::TEXT IS NULL OR t.name ILIKE '%' || $2 || '%')
        ORDER BY s.start_date DESC
        LIMIT $3 OFFSET $4
      `;
  
      const result = await pool.query(query, [language_code, search || null, limit, offset]);
  
      // 📌 Fix JSON parsing issue
      const parseJSON = (data) => {
        if (!data) return []; // Return an empty array if data is null
        if (typeof data === "string") {
          try {
            return JSON.parse(data);
          } catch (e) {
            console.error("Invalid JSON:", data);
            return [];
          }
        }
        return data; // If it's already an object, return as is
      };
  
      const schemes = result.rows.map((row) => ({
        id: row.id,
        type: row.type,
        gov_level: row.gov_level,
        state_or_org: row.state_or_org,
        start_date: row.start_date,
        end_date: row.end_date,
        status: row.status,
        official_link: row.official_link,
        funding_amount: row.funding_amount,
        image_url: row.image_url,
        name: row.name,
        description: row.description,
        benefits: parseJSON(row.benefits),
        eligibility: parseJSON(row.eligibility),
        application_process: parseJSON(row.application_process),
      }));
  
      res.status(200).json({ count: schemes.length, schemes });
    } catch (err) {
      console.error("Error fetching schemes:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };

const addScheme = async (req, res) => {
    const client = await pool.connect(); // Get a DB client for transaction
    try {
      const { type, gov_level, state_or_org, start_date, end_date, status, official_link, funding_amount, image_url, language_data } = req.body;
  
      // Validate required fields
      if (!type || !status || !language_data || language_data.length === 0) {
        return res.status(400).json({ error: "Missing required fields" });
      }
  
      await client.query("BEGIN"); // Start a transaction
  
      // 📌 Insert into `schemes_subsidies`
      const insertSchemeQuery = `
        INSERT INTO schemes_subsidies 
        (type, gov_level, state_or_org, start_date, end_date, status, official_link, funding_amount, image_url)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING id`;
      
      const schemeValues = [type, gov_level, state_or_org, start_date, end_date, status, official_link, funding_amount, image_url];
      const schemeResult = await client.query(insertSchemeQuery, schemeValues);
      const schemeId = schemeResult.rows[0].id;
  
      // 📌 Insert translations into `scheme_translations`
      const insertTranslationQuery = `
        INSERT INTO scheme_translations 
        (scheme_id, language_code, name, description, benefits, eligibility, application_process)
        VALUES ($1, $2, $3, $4, $5, $6, $7)`;
      
      for (const lang of language_data) {
        const langValues = [
          schemeId,
          lang.language_code,
          lang.name,
          lang.description,
          JSON.stringify(lang.benefits),
          JSON.stringify(lang.eligibility),
          JSON.stringify(lang.application_process),
        ];
        await client.query(insertTranslationQuery, langValues);
      }
  
      await client.query("COMMIT"); // Commit transaction
      res.status(201).json({ message: "Scheme added successfully", scheme_id: schemeId });
    } catch (err) {
      await client.query("ROLLBACK"); // Rollback on error
      console.error("Error adding scheme:", err);
      res.status(500).json({ error: "Internal server error" });
    } finally {
      client.release(); // Release DB connection
    }
  };

  const upsertScheme = async (req, res) => {
    try {
      console.log("hello");
        const { id, type, gov_level, state_or_org, start_date, end_date, status, official_link, funding_amount, image_url } = req.body;

        const query = `
            INSERT INTO schemes_subsidies (id, type, gov_level, state_or_org, start_date, end_date, status, official_link, funding_amount, image_url)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
            ON CONFLICT (id) 
            DO UPDATE SET 
                type = EXCLUDED.type,
                gov_level = EXCLUDED.gov_level,
                state_or_org = EXCLUDED.state_or_org,
                start_date = EXCLUDED.start_date,
                end_date = EXCLUDED.end_date,
                status = EXCLUDED.status,
                official_link = EXCLUDED.official_link,
                funding_amount = EXCLUDED.funding_amount,
                image_url = EXCLUDED.image_url
            RETURNING *;
        `;

        const values = [id || null, type, gov_level, state_or_org, start_date, end_date, status, official_link, funding_amount, image_url];
        const result = await pool.query(query, values);

        res.json({ success: true, scheme: result.rows[0] });

    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, message: 'Server Error' });
    }
};


const upsertTranslation = async (req, res) => {
  try {
      const { scheme_id, language_code, name, description, benefits, eligibility, application_process } = req.body;

      //Convert JSON arrays to strings
      const formattedBenefits = JSON.stringify(benefits);
      const formattedEligibility = JSON.stringify(eligibility);
      const formattedApplicationProcess = JSON.stringify(application_process);

      const query = `
          INSERT INTO scheme_translations (scheme_id, language_code, name, description, benefits, eligibility, application_process)
          VALUES ($1, $2, $3, $4, $5, $6, $7)
          ON CONFLICT (scheme_id, language_code)
          DO UPDATE SET 
              name = EXCLUDED.name,
              description = EXCLUDED.description,
              benefits = EXCLUDED.benefits,
              eligibility = EXCLUDED.eligibility,
              application_process = EXCLUDED.application_process
          RETURNING *;
      `;

      const values = [
          scheme_id, 
          language_code, 
          name, 
          description, 
          formattedBenefits, 
          formattedEligibility, 
          formattedApplicationProcess
      ];

      const result = await pool.query(query, values);

      res.json({ success: true, translation: result.rows[0] });

  } catch (error) {
      console.error(error);
      res.status(500).json({ success: false, message: 'Server Error' });
  }
};

const deleteScheme = async (req, res) => {
  try {
      const { id } = req.body;

      if (!id) {
          return res.status(400).json({ success: false, message: "Scheme ID is required" });
      }

      const query = `DELETE FROM schemes_subsidies WHERE id = $1 RETURNING *`;
      const result = await pool.query(query, [id]);

      if (result.rowCount === 0) {
          return res.status(404).json({ success: false, message: "Scheme not found" });
      }

      res.json({ success: true, message: "Scheme deleted successfully", deletedScheme: result.rows[0] });
  } catch (error) {
      console.error("Error deleting scheme:", error);
      res.status(500).json({ success: false, message: "Server error" });
  }
};


export { getallSchemes, addScheme, getstateSchemes, upsertScheme, upsertTranslation, deleteScheme, getTranslationSchemes };