import run from "../utils/gemini.js";


const plantDiagnose = async (req , res) => {
    const imageLocalPath = req.file?.path
    await run(imageLocalPath);
    // console.log(process.env.GEMINI_API_KEY);
    if(!imageLocalPath) return res.status(400).json({message: 'Image is required'});
    return res.status(200).json({message: 'Plant Diagnose'});
}

export { plantDiagnose }