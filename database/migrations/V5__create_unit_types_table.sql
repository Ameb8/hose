CREATE TABLE unit_types (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    property_id BIGINT NOT NULL,

    name TEXT NOT NULL, 
    bedrooms INT NOT NULL,
    bathrooms INT NOT NULL,

    rent_cents INT NOT NULL,

    availability_date DATE,
    total_units INT,
    available_units INT,

    description TEXT,

    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),

    CONSTRAINT fk_unit_types_property
        FOREIGN KEY (property_id)
            REFERENCES properties(id)
            ON DELETE CASCADE
);
