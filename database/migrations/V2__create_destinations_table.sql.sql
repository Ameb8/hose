CREATE TABLE destinations (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    name TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('property', 'cwu', 'bus_stop', 'other')),
    description TEXT,

    -- Plain lat/lng storage (recommended)
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,

    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),

    -- Basic coordinate sanity checks
    CONSTRAINT chk_latitude  CHECK (latitude BETWEEN -90 AND 90),
    CONSTRAINT chk_longitude CHECK (longitude BETWEEN -180 AND 180)
);
