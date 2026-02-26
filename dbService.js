import pkg from "pg";
import { CONFIG } from "./config.js";

const { Pool } = pkg;

const pool = new Pool(CONFIG.POSTGRES);

export async function queryDatabase(sql) {
    const result = await pool.query(sql);
    return result.rows;
}
