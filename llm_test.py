import json
import ollama

# Load JSON data once
with open("hose_data.json", "r", encoding="utf-8") as f:
    data = json.load(f)

print("HOSE LLM Test")
print("Type 'exit' to quit.\n")

while True:
    question = input("Ask: ")

    if question.lower() in ["exit", "quit", "q"]:
        print("Goodbye.")
        break

    prompt = f"""
You are an assistant for the HOSE student housing platform.

Use ONLY the property data below.
Do NOT make up information.
If the answer is not in the data, say you it's not list/provided.

Property Data:
{json.dumps(data, indent=2)}

Question:
{question}
"""

    response = ollama.chat(
        model="llama3",
        messages=[{"role": "user", "content": prompt}]
    )

    print("\nResponse:\n")
    print(response["message"]["content"])
    print("\n" + "-"*50 + "\n")
