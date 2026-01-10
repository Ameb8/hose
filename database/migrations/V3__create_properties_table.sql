CREATE TABLE IF NOT EXISTS properties (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- Surrogate key for easy reference
    address_id BIGINT NOT NULL, -- FK to addresses
    unit VARCHAR(20), -- Optional unit number for apartments
    bedrooms INT,
    bathrooms INT,
    rent BIGINT, -- Rent stored as integer for number of cents in cost per month
    available_from DATE,
    coordinates GEOGRAPHY(Point, 4326), -- GPS coordinates of property
    

    -- Foreign key for property's address
    CONSTRAINT fk_address 
        FOREIGN KEY (address_id) 
            REFERENCES addresses(id),
    
    -- enforce uniqueness of address + unit (unit can be NULL)
    CONSTRAINT uc_address_unit 
        UNIQUE (address_id, unit)
);
