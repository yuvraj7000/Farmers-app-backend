import { GoogleGenerativeAI } from "@google/generative-ai";
import fs from "fs";
// Converts local file information to base64
function fileToGenerativePart(path, mimeType) {
  return {
    inlineData: {
      data: Buffer.from(fs.readFileSync(path)).toString("base64"),
      mimeType
    },
  };
}

async function run(localFilePath) {
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
  const model = genAI.getGenerativeModel({ model: "gemini-1.5-pro" });

  const prompt = "Write an advertising jingle showing how the product in the first image could solve the problems shown in the second two images.";

  const imageParts = [
      fileToGenerativePart(localFilePath, "image/jpeg"),
  ];

  const generatedContent = await model.generateContent([prompt, ...imageParts]);
  
  console.log(generatedContent.response.text());
}

export default run;