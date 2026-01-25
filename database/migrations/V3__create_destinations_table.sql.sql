CREATE TABLE destinations (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('property', 'cwu', 'bus_stop', 'other')),
    description TEXT,

    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,

    address_id BIGINT,

    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),

    CONSTRAINT chk_latitude  CHECK (latitude BETWEEN -90 AND 90),
    CONSTRAINT chk_longitude CHECK (longitude BETWEEN -180 AND 180),

    CONSTRAINT fk_destination_address
        FOREIGN KEY (address_id)
            REFERENCES addresses(id)
            ON DELETE SET NULL,

    CONSTRAINT chk_property_has_address
        CHECK (
            type != 'property'
            OR address_id IS NOT NULL
        )
);
