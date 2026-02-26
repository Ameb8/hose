import axios from "axios";
import { CONFIG } from "./config.js";

export async function fetchAllData() {
    const destinations = await axios.get(
        `${CONFIG.JAVA_API_BASE}/destinations`
    );

    // Example: fetch first 10 properties
    const properties = [];

    for (let i = 1; i <= 10; i++) {
        try {
            const prop = await axios.get(
                `${CONFIG.JAVA_API_BASE}/properties/${i}`
            );
            properties.push(prop.data);
        } catch (err) {
            break;
        }
    }

    return {
        destinations: destinations.data,
        properties
    };
}
