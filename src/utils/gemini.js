import { GoogleGenerativeAI } from "@google/generative-ai";
import fs from "fs";
import 'dotenv/config'; // Ensure dotenv is configured

// Converts local file information to base64
function fileToGenerativePart(path, mimeType) {
  return {
    inlineData: {
      data: Buffer.from(fs.readFileSync(path)).toString("base64"),
      mimeType
    },
  };
}

async function run(localFilePath, language) {
  const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
  const model = genAI.getGenerativeModel({ model: "gemini-1.5-pro" });

const prompt = `
Prompt:
"You are an expert in plant pathology and agriculture. Given an image of a plant, analyze it to determine whether it shows signs of disease. If the image is valid and contains a diseased plant, identify the disease and provide a structured response in JSON format with the following details:

response language: ${language}.
Description: A brief explanation of the disease and its symptoms.
Regular Solution:  effective conventional methods to treat the disease.
Organic Solution: natural or organic remedies for farmers who prefer eco-friendly treatments.
Important Notes: Additional precautions, prevention tips, or crucial information regarding the disease.
If the image does not contain a plant or is unclear, return a JSON response indicating the issue.

Output Format:
{
  "cure": true,
  "Description": "Brief explanation of the disease and its symptoms.",
  "Regular solution": ["Regular Solutions"],
  "Organic solution": ["Organic solutions"],
  "important notes": ["Relevant precaution or prevention tip"]
}
If the image is invalid or not a plant image, than return:
{
  "cure": false
}
Ensure the response is accurate, concise, and informative for farmers seeking practical solutions."
  `;

  const imageParts = [
    fileToGenerativePart(localFilePath, "image/jpeg"),
  ];

  const generatedContent = await model.generateContent([prompt, ...imageParts]);
  
  const response = await generatedContent.response.text();
  console.log(response);
  return response;
}

export default run;