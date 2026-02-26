import axios from "axios";
import { CONFIG } from "./config.js";

export async function callLLM(prompt) {
    try {
        const response = await axios.post(CONFIG.OLLAMA_URL, {
            model: CONFIG.OLLAMA_MODEL,
            prompt,
            stream: false
        });

        console.log("Raw Ollama response:", response.data);

        if (response.data?.response) {
            return response.data.response.trim();
        }

        if (response.data?.message?.content) {
            return response.data.message.content.trim();
        }

        if (response.data?.error) {
            console.error("Ollama error:", response.data.error);
            return "AI encountered a model error.";
        }

        console.error("Unexpected format:", response.data);
        return "AI returned an unexpected response.";

    } catch (error) {
        console.error("LLM Request Failed:", error.message);
        return "AI request failed.";
    }
}