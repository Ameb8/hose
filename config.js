export const CONFIG = {
    MODE: "sql", // "api" or "sql"
    
    OLLAMA_URL: "http://localhost:11434/api/generate",
    OLLAMA_MODEL: "llama3",

    JAVA_API_BASE: "https://bestsellers-navigate-bone-this.trycloudflare.com",

    POSTGRES: {
		user: "postgres_user",
		host: "localhost",
		database: "hose_db_replica",
		password: "postgres_password",
		port: 5432
	}
};
