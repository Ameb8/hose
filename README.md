# HOSE Application – Setup & Local Run Guide

## Overview

This document provides step-by-step instructions for running the HOSE application locally.
The system uses:

* **Docker** → for the PostgreSQL database
* **Node.js** → for the backend server
* **Ollama (LLaMA)** → for AI/LLM responses

This hybrid setup keeps the database portable while allowing the backend and AI to run locally for easier development and testing.

---

## System Requirements

Ensure the following are installed:

### Core Software

* **Node.js** (v18 or newer recommended)
* **npm** (included with Node.js)
* **Docker Desktop** (for database container)
* **Git** (optional, for cloning repository)

### AI / LLM

* **Ollama**

  * Download: https://ollama.com
  * Used to run local LLM models (e.g., LLaMA)

---

## Project Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Ameb8/hose.git
cd hose
```

---

### 2. Install Dependencies

```bash
npm install
```

---

### 3. Configure Environment Variables

Create a `.env` file in the root directory:

```env
POSTGRES_DB=hose_db
POSTGRES_USER=postgres_user
POSTGRES_PASSWORD=postgres_password
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

OLLAMA_URL=http://localhost:11434
MODEL_NAME=llama3
```

Ensure values match your local setup.

---

## Database Setup (Docker)

The PostgreSQL database runs inside a Docker container.

### Step 1: Start the Database

Navigate to the database folder (if applicable), then run:

```bash
docker compose up -d
```

This will:

* Start PostgreSQL in a container
* Expose it on **localhost:5432**

---

### Step 2: Create the Database

If not auto-created, connect using pgAdmin or terminal and run:

```sql
CREATE DATABASE hose_db;
```

---

## Running the Application

### Step 1: Start the LLM (Ollama)

```bash
ollama run llama3
```

Leave this running in a separate terminal.

---

### Step 2: Start the Backend Server

```bash
node server.js
```

Expected output:

```
Server running on port XXXX
Connected to database
```

---

### Step 3: Open the Frontend

* Open `index.html` directly in your browser
  **OR**
* If using a frontend framework:

```bash
npm start
```

---

## Testing the Application

1. Open the application in your browser
2. Enter sample queries (e.g., apartment searches)
3. Verify:

   * Database queries return results
   * AI responses are generated
   * UI is readable and properly formatted

---

## Common Issues & Fixes

### Database Connection Fails

* Ensure Docker container is running:

```bash
docker ps
```

* Verify `.env` credentials
* Confirm port `5432` is available

---

### LLM Not Responding

* Ensure Ollama is running
* Check installed models:

```bash
ollama list
```

---

### Port Already in Use

* Change the port in `server.js`
* Or stop the process using the port

---

### Docker Issues

```bash
docker compose down
docker compose up -d
```

---

## Switching to a Different LLM Model

The system is designed to allow easy swapping of LLM providers.

---

### Option 1: Use a Different Ollama Model

```bash
ollama run mistral
```

Update `.env`:

```env
MODEL_NAME=mistral
```

---

### Option 2: Use OpenAI API (Cloud-Based)

1. Install dependency:

```bash
npm install openai
```

2. Add to `.env`:

```env
OPENAI_API_KEY=your_api_key_here
```

3. Replace Ollama logic in backend:

```javascript
import OpenAI from "openai";

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const response = await client.chat.completions.create({
  model: "gpt-4o-mini",
  messages: [{ role: "user", content: userInput }],
});
```

---

### Option 3: Use HuggingFace Models

```bash
npm install @huggingface/inference
```

Replace LLM API calls with HuggingFace inference.

---

## Why LLMs Can Be Swapped Easily

* LLM interaction is isolated in the backend
* Only one module/function needs modification
* No changes required for:

  * Database
  * Frontend UI
  * Core logic

---

## Architecture Notes

* PostgreSQL runs in Docker for consistency and portability
* Backend (Node.js) runs locally for simplicity
* LLM runs locally via Ollama for fast responses

This hybrid approach balances ease of setup with real-world architecture practices.

---

## Summary

To run the application:

1. Start Docker (PostgreSQL)
2. Start Ollama (LLM)
3. Run backend (`node server.js`)
4. Open frontend

---

If issues occur, check:

* `.env` configuration
* Docker container status
* Ollama status
* Console logs

---
