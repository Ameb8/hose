import readline from "readline";
import fetch from "node-fetch";

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

async function askQuestion() {
    rl.question("You: ", async (input) => {

        if (input.toLowerCase() === "exit") {
            rl.close();
            return;
        }

        const response = await fetch("http://localhost:3001/ask-ai", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ query: input })
        });

        const data = await response.json();

        console.log("\nAI:", data.answer);
        console.log("");

        askQuestion();
    });
}

console.log("HOSE AI Assistant (type 'exit' to quit)\n");
askQuestion();