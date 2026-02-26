import axios from "axios";
import { readFile, unlink } from "node:fs/promises";

const invokeUrl = "https://integrate.api.nvidia.com/v1/chat/completions";

const buildPrompt = (language) => `
You are an expert in plant pathology and agriculture. Given an image of a plant, analyze it to determine whether it shows signs of disease.
If the image is valid and contains a diseased plant, identify the disease and provide a structured response in JSON format with the following details:

response language: ${language}.
Description: A brief explanation of the disease and its symptoms.
Regular Solution: Effective conventional methods to treat the disease.
Organic Solution: Natural or organic remedies for farmers who prefer eco-friendly treatments.
Important Notes: Additional precautions, prevention tips, or crucial information regarding the disease.

Output Format:
{
  "cure": true,
  "Description": "Brief explanation of the disease and its symptoms.",
  "symptoms": ["symptoms of the disease"],
  "cause": ["cause of the disease"],
  "Regular solution": ["Regular Solutions"],
  "chemical solution": ["Chemical present in the solution"],
  "Organic solution": ["Organic solutions"],
  "important notes": ["Relevant precaution or prevention tip"]
}

If the image is invalid or does not contain a plant, then return:
{
  "cure": false,
  "remarks": "this plant looks healthy or this not a plant image , this image is about { what is in the image } or this image is not clear enough to diagnose"
}
Ensure the response is accurate, concise, and informative for farmers seeking practical solutions.
`;

const plantDiagnose = async (req, res) => {
  const language = req.body.language || "english";
  const imageLocalPath = req.file?.path;

  if (!imageLocalPath) {
    return res.status(400).json({ message: "Image is required" });
  }

  if (!process.env.NVIDIA_API_KEY) {
    await unlink(imageLocalPath).catch(() => {});
    return res.status(500).json({
      message: "Diagnose failed",
      error: "Missing NVIDIA_API_KEY in environment",
    });
  }

  try {
    const imageBuffer = await readFile(imageLocalPath);
    const imageBase64 = imageBuffer.toString("base64");
    const mimeType = req.file?.mimetype || "image/jpeg";

    const payload = {
      model: "qwen/qwen3.5-397b-a17b",
      messages: [
        {
          role: "user",
          content: [
            { type: "text", text: buildPrompt(language) },
            {
              type: "image_url",
              image_url: {
                url: `data:${mimeType};base64,${imageBase64}`,
              },
            },
          ],
        },
      ],
      max_tokens: 4096,
      temperature: 0.6,
      top_p: 0.95,
      stream: false,
      chat_template_kwargs: { enable_thinking: true },
    };

    const response = await axios.post(invokeUrl, payload, {
      headers: {
        Authorization: `Bearer ${process.env.NVIDIA_API_KEY}`,
        Accept: "application/json",
      },
      responseType: "json",
      timeout: 120000,
    });

    const output = response?.data?.choices?.[0]?.message?.content || null;

    return res.status(200).json({
      message: "Diagnose successful",
      diagnose: output,
      raw: response.data,
    });
  } catch (error) {
    const status = error?.response?.status || 500;
    const details = error?.response?.data || error?.message || "Unknown error";

    return res.status(status).json({
      message: "Diagnose failed",
      error: details,
    });
  } finally {
    await unlink(imageLocalPath).catch(() => {});
  }
};

export { plantDiagnose };
