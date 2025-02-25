import run from "../utils/gemini.js";
import fs from "fs";

const plantDiagnose = async (req , res) => {
   const language = req.body.language || 'english';
    const imageLocalPath = req.file?.path
    if(!imageLocalPath) return res.status(400).json({message: 'Image is required'});
    try {
        const diagnose = await run(imageLocalPath, language);
    
        // Delete the local file
        fs.unlink(imageLocalPath, (err) => {
          if (err) {
            console.error("Failed to delete local file:", err);
          }
        });
    
        return res.status(200).json({ message: 'Diagnose successful', diagnose });
      } catch (error) {
        console.error("Error during diagnosis:", error);
        if(imageLocalPath) {
          fs.unlink(imageLocalPath, (err) => {
            if (err) {
              console.error("Failed to delete local file:", err);
            }
          });
        return res.status(500).json({ message: 'Diagnose failed', error });
      }
}
}

export { plantDiagnose}



