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
tell something about content in this image
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
    // const cleanedResponse = textResponse
    //   .replace(/```json/g, '') 
    //   .replace(/```/g, '')      
    //   .trim();
  
    // // Attempt to parse the JSON response
    // const parsedResponse = JSON.parse(cleanedResponse);
    return textResponse;
  } catch (error) {
    console.error("Error processing the image:", error);
    return { error: "Failed to process the image or parse the response." };
  }
}

export default analyzePlant ;