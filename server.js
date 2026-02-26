import dotenv from "dotenv";
dotenv.config();

import express from "express";
import cors from "cors";
import { CONFIG } from "./config.js";
import { callLLM } from "./llmService.js";
import { fetchAllData } from "./apiService.js";
import { queryDatabase } from "./dbService.js";

const app = express();
app.use(cors());
app.use(express.json());

let conversationHistory = [];
let lastQueryResult = null;

function safeString(value) {
    if (typeof value === "string" && value.trim() !== "") {
        return value.trim();
    }
    return "AI failed to generate a response.";
}

app.post("/ask-ai", async (req, res) => {
    const userQuery = req.body.query;

    try {

        if (CONFIG.MODE === "sql") {

            const lower = userQuery.toLowerCase();

			const followUpKeywords = [
				"that",
				"it",
				"they",
				"those",
				"there",
				"address",
				"location",
				"where",
				"pet",
				"pets",
				"deposit",
				"phone",
				"contact"
			];

			const isFollowUp =
				lastQueryResult &&
				followUpKeywords.some(word => lower.includes(word));

            let dbResult;

            if (!isFollowUp) {

                const formatPrompt = `
You are a rental assistant.

Respond professionally and concisely.

Formatting Rules:

- If the user asks for the cheapest or most expensive apartment
  or cheapest/most expensive [X bedroom]:
  - Return ONLY ONE result.
  - Include:
      property_name
      unit_name
      bedrooms
      bathrooms
      rent_dollars
  - Do NOT include address unless explicitly requested.
  - Do NOT include comparisons.
  - Do NOT include commentary.
  - Respond in one clean sentence.
  Sorting Rules:

- If the user asks for the cheapest apartment:
    ORDER BY unit_types.rent_cents ASC LIMIT 1

- If the user asks for the most expensive apartment:
    ORDER BY unit_types.rent_cents DESC LIMIT 1

- If the user asks for the cheapest X bedroom:
    Add WHERE unit_types.bedrooms = X
    ORDER BY unit_types.rent_cents ASC LIMIT 1

- If the user asks for the most expensive X bedroom:
    Add WHERE unit_types.bedrooms = X
    ORDER BY unit_types.rent_cents DESC LIMIT 1

- If the user asks for multiple results:
  - List them briefly.
  - Only include property_name, unit_name, bedrooms, bathrooms, rent_dollars.

- If the user asks about address:
  - Only provide address.

- If the user asks about pets:
  - Only provide pet status.
  
- If the user specifies number of bedrooms (e.g., 2 bedroom):
  - Add WHERE unit_types.bedrooms = [number]
  - Then ORDER BY unit_types.rent_cents ASC
  - Then LIMIT 1

Be concise and professional.

Data:
${JSON.stringify(dbResult, null, 2)}

User question:
${userQuery}
`;

                const rawSQL = await callLLM(sqlPrompt);
                const generatedSQL = safeString(rawSQL);

                console.log("Generated SQL:", generatedSQL);

                if (!generatedSQL.toLowerCase().startsWith("select")) {
                    return res.json({ answer: "AI generated invalid SQL." });
                }

                dbResult = await queryDatabase(generatedSQL);
                console.log("DB Result:", dbResult);

                if (!dbResult || dbResult.length === 0) {
                    return res.json({ answer: "No matching results found." });
                }

                lastQueryResult = dbResult;

            } else {
                dbResult = lastQueryResult;
                console.log("Using previous DB result.");
            }

            conversationHistory.push({
                role: "user",
                content: userQuery
            });

            conversationHistory.push({
                role: "system",
                content: JSON.stringify(dbResult)
            });

            // Limit history size (prevents LLM overload)
            if (conversationHistory.length > 6) {
                conversationHistory = conversationHistory.slice(-6);
            }

            const formatPrompt = `
You are a professional rental assistant for CWU students.

Using ONLY the data below, answer the user's question naturally in full sentences.

Do NOT list raw fields.
Do NOT show property IDs or unit IDs.
Present the answer conversationally.

Round rent to exactly two decimal places.

Data:
${JSON.stringify(dbResult, null, 2)}

User question:
${userQuery}
`;

            const rawAnswer = await callLLM(formatPrompt);
            const finalAnswer = safeString(rawAnswer);

            conversationHistory.push({
                role: "assistant",
                content: finalAnswer
            });

            return res.json({ answer: finalAnswer });
        }

    } catch (err) {
        console.error("Server Error:", err);
        return res.status(500).json({ answer: "Server error occurred." });
    }
});

app.listen(3001, () => {
    console.log("AI Backend running on http://localhost:3001");
});

callLLM("Hello").then(() => {
    console.log("LLM warmed up.");
});