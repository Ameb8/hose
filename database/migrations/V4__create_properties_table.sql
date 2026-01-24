CREATE TABLE properties (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name TEXT NOT NULL,
    property_type TEXT NOT NULL CHECK (property_type IN ('apartment', 'dorm', 'house')),

    description TEXT,

    contact_phone TEXT,
    contact_email TEXT,

    address_id BIGINT NOT NULL,
    destination_id BIGINT NOT NULL UNIQUE,

    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),

    CONSTRAINT fk_properties_address
        FOREIGN KEY (address_id)
            REFERENCES addresses(id)
            ON DELETE RESTRICT,

    CONSTRAINT fk_properties_destination
        FOREIGN KEY (destination_id)
            REFERENCES destinations(id)
            ON DELETE CASCADE
)
;