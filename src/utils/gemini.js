import { GoogleGenerativeAI } from "@google/generative-ai";
import { PromptTemplate } from "@langchain/core/prompts"; // Added missing import
import fs from "fs";
import 'dotenv/config';

function fileToBase64(path) {
  return Buffer.from(fs.readFileSync(path)).toString("base64");
}

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-2.0-flash-lite" });

const promptTemplate = `
You are an expert in plant pathology and agriculture. Given an image of a plant, analyze it to determine whether it shows signs of disease.
If the image is valid and contains a diseased plant, identify the disease and provide a structured response in JSON format with the following details:

response language: {language}.
Description: A brief explanation of the disease and its symptoms.
Regular Solution: Effective conventional methods to treat the disease.
Organic Solution: Natural or organic remedies for farmers who prefer eco-friendly treatments.
Important Notes: Additional precautions, prevention tips, or crucial information regarding the disease.

Output Format:
{{
  "cure": true,
  "Description": "Brief explanation of the disease and its symptoms.",
  "symptoms": ["symptoms of the disease"],
  "Regular solution": ["Regular Solutions"],
  "Organic solution": ["Organic solutions"],
  "important notes": ["Relevant precaution or prevention tip"]
}}

If the image is invalid or does not contain a plant, then return:
{{
  "cure": false
}}
Ensure the response is accurate, concise, and informative for farmers seeking practical solutions.
`;

// Create a LangChain prompt template.
const prompt = new PromptTemplate({
  template: promptTemplate,
  inputVariables: ["language"],
});

// Function that analyzes the plant image.
async function analyzePlant(localFilePath, language) {

  const base64Image = fileToBase64(localFilePath);
  const formattedPrompt = await prompt.format({ language });
  const fullPrompt = `${formattedPrompt}\n\nImage (Base64):\n${base64Image}`;

  try {
    
    const generatedContent = await model.generateContent([fullPrompt]);
    const textResponse = await generatedContent.response.text();
    console.log("Raw response:", textResponse);
    
    // Clean the response by removing markdown code blocks
    const cleanedResponse = textResponse
      .replace(/```json/g, '') 
      .replace(/```/g, '')      
      .trim();
  
    // Attempt to parse the JSON response
    const parsedResponse = JSON.parse(cleanedResponse);
    return parsedResponse;
  } catch (error) {
    console.error("Error processing the image:", error);
    return { error: "Failed to process the image or parse the response." };
  }
}

export default analyzePlant ;