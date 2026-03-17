import dotenv from "dotenv";
dotenv.config();

import express from "express";
import cors from "cors";
import { queryDatabase } from "./dbService.js";

const app = express();
app.use(cors());
app.use(express.json());

/* ========================================
FORMATTERS
======================================== */

function formatUnitRows(rows) {

    let output = "2 Bedroom Apartments Found\n\n";

    rows.forEach((r, i) => {

        output +=
`${i + 1}. ${r.property_name}
   Unit: ${r.unit_name}
   Bedrooms: ${r.bedrooms}
   Bathrooms: ${r.bathrooms}
   Rent: $${r.rent_dollars}
--------------------------------
`;
    });

    output += `Total Results: ${rows.length}`;

    return output;
}

function formatComplexRows(rows) {
    return rows.map((r, i) =>
        `${i + 1}. ${r.name}`
    ).join("\n") + `\n\nTotal Complexes: ${rows.length}`;
}

function formatSingleUnit(row) {
    return `${row.property_name} - ${row.unit_name} - ${row.bedrooms} bedrooms - ${row.bathrooms} bathrooms - $${row.rent_dollars}`;
}

/* ========================================
QUERY EXTRACTORS
======================================== */

function extractBedroom(lower) {

    if (lower.includes("studio"))
        return "studio";

    const match = lower.match(/(\d+)\s*bed/);

    if (match)
        return parseInt(match[1]);

    return null;
}

function extractBathroom(lower) {

    const match = lower.match(/(\d+)\s*bath/);

    if (match)
        return parseInt(match[1]);

    return null;
}

function extractPriceRange(lower) {

    const between = lower.match(/between\s*\$?(\d+)\s*(and|-)\s*\$?(\d+)/);

    if (between) {

        let price1 = parseInt(between[1]);
        let price2 = parseInt(between[3]);

        const min = Math.min(price1, price2);
        const max = Math.max(price1, price2);

        return { min, max };
    }

    const under = lower.match(/(under|below)\s*\$?(\d+)/);

    if (under)
        return { min: 0, max: parseInt(under[2]) };

    const over = lower.match(/(over|above)\s*\$?(\d+)/);

    if (over)
        return { min: parseInt(over[2]), max: null };

    return null;
}

/* ========================================
PROPERTY DETECTION
======================================== */

async function detectPropertyName(userQuery) {

    const properties = await queryDatabase(`SELECT name FROM properties`);
    const lowerQuery = userQuery.toLowerCase();

    const matches = [];

    const ignoredWords = [
        "campus",
        "cwu",
        "bus",
        "stop",
        "distance"
    ];

    for (const property of properties) {

        const name = property.name.toLowerCase();

        // full name match
        if (lowerQuery.includes(name)) {
            matches.push(property.name);
            continue;
        }

        // first word fallback
        const firstWord = name.split(" ")[0];

        if (
            lowerQuery.includes(firstWord) &&
            !ignoredWords.includes(firstWord)
        ) {
            matches.push(property.name);
        }
    }

    return [...new Set(matches)];
}

/* ========================================
MISSPELLING SUGGESTIONS
======================================== */

async function suggestProperties(userQuery) {

    const properties = await queryDatabase(`SELECT name FROM properties`);
    const lower = userQuery.toLowerCase();

    return properties
        .map(p => p.name)
        .filter(name => lower.includes(name.toLowerCase().slice(0,4)))
        .slice(0,3);
}

/* ========================================
BEDROOM CONDITION
======================================== */

function buildBedroomCondition(bedroom) {

    if (bedroom === "studio")
        return `(unit_types.bedrooms = 0 OR unit_types.name ILIKE '%studio%')`;

    return `unit_types.bedrooms = ${bedroom}`;
}

/* ========================================
MAIN ROUTE
======================================== */

app.post("/ask-ai", async (req, res) => {

    const userQuery = req.body?.query || "";
    const lower = userQuery.toLowerCase();

    try {

        const bedroom = extractBedroom(lower);
        const bathroom = extractBathroom(lower);
        const priceRange = extractPriceRange(lower);

        /* ========================================
        BEDROOM SEARCH
        (RUN FIRST)
        ======================================== */

        if (bedroom !== null) {

            const condition = buildBedroomCondition(bedroom);

            const rows = await queryDatabase(`
                SELECT properties.name AS property_name,
                       unit_types.name AS unit_name,
                       unit_types.bedrooms,
                       unit_types.bathrooms,
                       ROUND(unit_types.rent_cents/100.0,2) AS rent_dollars
                FROM properties
                JOIN unit_types ON unit_types.property_id = properties.id
                WHERE ${condition}
                ORDER BY unit_types.rent_cents ASC
            `);

            if (!rows.length)
                return res.json({
                    answer: `No ${bedroom === "studio" ? "studio" : bedroom + " bedroom"} apartments found.`
                });

            return res.json({ answer: formatUnitRows(rows) });
        }

        /* ========================================
        BATHROOM SEARCH
        ======================================== */

        if (bathroom !== null) {

            const rows = await queryDatabase(`
                SELECT properties.name AS property_name,
                       unit_types.name AS unit_name,
                       unit_types.bedrooms,
                       unit_types.bathrooms,
                       ROUND(unit_types.rent_cents/100.0,2) AS rent_dollars
                FROM properties
                JOIN unit_types ON unit_types.property_id = properties.id
                WHERE unit_types.bathrooms = ${bathroom}
                ORDER BY unit_types.rent_cents ASC
            `);

            if (!rows.length)
                return res.json({
                    answer: `No apartments with ${bathroom} bathrooms found.`
                });

            return res.json({ answer: formatUnitRows(rows) });
        }

        /* ========================================
        PRICE FILTER
        ======================================== */

        if (priceRange) {

            let condition;

            if (priceRange.max !== null)
                condition = `unit_types.rent_cents BETWEEN ${priceRange.min * 100} AND ${priceRange.max * 100}`;
            else
                condition = `unit_types.rent_cents >= ${priceRange.min * 100}`;

            const rows = await queryDatabase(`
                SELECT properties.name AS property_name,
                       unit_types.name AS unit_name,
                       unit_types.bedrooms,
                       unit_types.bathrooms,
                       ROUND(unit_types.rent_cents/100.0,2) AS rent_dollars
                FROM properties
                JOIN unit_types ON unit_types.property_id = properties.id
                WHERE ${condition}
                ORDER BY unit_types.rent_cents ASC
            `);

            if (!rows.length)
                return res.json({ answer: "No apartments found in that price range." });

            return res.json({ answer: formatUnitRows(rows) });
        }

        /* ========================================
        CHEAPEST UNIT
        ======================================== */

        if (lower.includes("cheapest")) {

            const row = (await queryDatabase(`
                SELECT properties.name AS property_name,
                       unit_types.name AS unit_name,
                       unit_types.bedrooms,
                       unit_types.bathrooms,
                       ROUND(unit_types.rent_cents/100.0,2) AS rent_dollars
                FROM properties
                JOIN unit_types ON unit_types.property_id = properties.id
                ORDER BY unit_types.rent_cents ASC
                LIMIT 1
            `))[0];

            return res.json({ answer: formatSingleUnit(row) });
        }

        /* ========================================
        COST OF PROPERTY
        ======================================== */

        if (lower.includes("cost") || lower.includes("price") || lower.includes("rent")) {

            const properties = await detectPropertyName(userQuery);

            if (!properties.length) {

                const suggestions = await suggestProperties(userQuery);

                if (suggestions.length)
                    return res.json({
                        answer:
                        `I couldn't find that property.\n\nDid you mean:\n` +
                        suggestions.map(s => `• ${s}`).join("\n")
                    });

                return res.json({
                    answer: "That property was not found in the housing database."
                });
            }

            const results = [];

            for (const property of properties) {

                const rows = await queryDatabase(`
                    SELECT properties.name AS property_name,
                           unit_types.name AS unit_name,
                           unit_types.bedrooms,
                           unit_types.bathrooms,
                           ROUND(unit_types.rent_cents/100.0,2) AS rent_dollars
                    FROM properties
                    JOIN unit_types ON unit_types.property_id = properties.id
                    WHERE properties.name = '${property}'
                    ORDER BY unit_types.rent_cents ASC
                `);

                if (rows.length)
                    results.push(`\n${property}\n${formatUnitRows(rows)}`);
            }

            return res.json({ answer: results.join("\n") });
        }

		/* ========================================
		DISTANCE TO CAMPUS
		======================================== */

		if (
			lower.includes("campus") ||
			lower.includes("cwu") ||
			lower.includes("distance to campus")
		) {

			const properties = await detectPropertyName(userQuery);

			if (!properties.length)
				return res.json({
					answer: "I couldn't find that property in the housing database."
				});

			const results = [];

			for (const property of properties) {

				const row = (await queryDatabase(`
					SELECT name, cwu_distance, cwu_mins
					FROM properties
					WHERE name = '${property}'
					LIMIT 1
				`))[0];

				if (row)
					results.push(
						`${row.name} is ${row.cwu_distance} miles from CWU (${row.cwu_mins} minute walk)`
					);
			}

			return res.json({ answer: results.join("\n") });
		}

		/* ========================================
		DISTANCE TO BUS STOP
		======================================== */

		if (lower.includes("bus") || lower.includes("bus stop")) {

			const properties = await detectPropertyName(userQuery);

			if (!properties.length)
				return res.json({
					answer: "I couldn't find that property in the housing database."
				});

			const results = [];

			for (const property of properties) {

				const row = (await queryDatabase(`
					SELECT name, bus_stop_distance, bus_stop_mins
					FROM properties
					WHERE name = '${property}'
					LIMIT 1
				`))[0];

				if (row)
					results.push(
						`${row.name} is ${row.bus_stop_distance} miles from the nearest bus stop (${row.bus_stop_mins} minute walk)`
					);
			}

			return res.json({ answer: results.join("\n") });
		}

        /* ========================================
        LIST ALL COMPLEXES
        ======================================== */

        if (
            (lower.includes("list") || lower.includes("show") || lower.includes("display"))
            &&
            (lower.includes("complex") || lower.includes("apartments") || lower.includes("housing"))
        ) {

            const rows = await queryDatabase(`
                SELECT name
                FROM properties
                ORDER BY name
            `);

            return res.json({ answer: formatComplexRows(rows) });
        }

        /* ========================================
        DEFAULT
        ======================================== */

        return res.json({
            answer: "I couldn't understand that question. Try asking about apartments, prices, bedrooms, or locations."
        });

    } catch (err) {

        console.error(err);

        return res.status(500).json({
            answer: "Something went wrong while searching the housing database."
        });
    }
});

const PORT = 3001;

app.listen(PORT, "0.0.0.0", () => {
    console.log(`AI Backend running on http://0.0.0.0:${PORT}`);
});