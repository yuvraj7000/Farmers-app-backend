import { GoogleGenerativeAI } from "@google/generative-ai";
import fs from "fs";
import { GoogleGenAI } from "@google/genai";


// Converts local file information to base64
function fileToGenerativePart(path, mimeType) {
  return {
    inlineData: {
      data: Buffer.from(fs.readFileSync(path)).toString("base64"),
      mimeType
    },
  };
}

async function analyzePlant(localFilePath, language) {

  const ai = new GoogleGenAI({});

  
const prompt = `
You are an expert in plant pathology and agriculture. Given an image of a plant, analyze it to determine whether it shows signs of disease.
If the image is valid and contains a diseased plant, identify the disease and provide a structured response in JSON format with the following details:

response language: ${language}.
Description: A brief explanation of the disease and its symptoms.
Regular Solution: Effective conventional methods to treat the disease.
Organic Solution: Natural or organic remedies for farmers who prefer eco-friendly treatments.
Important Notes: Additional precautions, prevention tips, or crucial information regarding the disease.

Output Format:
{{
  "cure": true,
  "Description": "Brief explanation of the disease and its symptoms.",
  "symptoms": ["symptoms of the disease"],
  "cause": ["cause of the disease"],
  "Regular solution": ["Regular Solutions"],
  "chemical solution": ["Chemical present in the solution"],
  "Organic solution": ["Organic solutions"],
  "important notes": ["Relevant precaution or prevention tip"]
}}

If the image is invalid or does not contain a plant, then return:
{{
  "cure": false,
  "remarks": "this plant looks healthy or this not a plant image , this image is about { what is in the image } or this image is not clear enough to diagnose"
}}
Ensure the response is accurate, concise, and informative for farmers seeking practical solutions.
  `;

  const base64ImageFile = fs.readFileSync(localFilePath, {
  encoding: "base64",
});


  const contents = [
  {
    inlineData: {
      mimeType: "image/jpeg",
      data: base64ImageFile,
    },
  },
  { text: prompt },
];
  
  const response = await ai.models.generateContent({
    model: "gemini-3-flash-preview",
    contents: contents,
  });

  console.log(response.text);


  return response.text;
}

export default analyzePlant;