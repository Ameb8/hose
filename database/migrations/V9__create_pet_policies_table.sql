CREATE TABLE pet_policies (
    property_id BIGINT PRIMARY KEY,

    allowed BOOLEAN NOT NULL,
    deposit_cents INT,
    restrictions TEXT,

    CONSTRAINT fk_pet_property
        FOREIGN KEY (property_id)
            REFERENCES properties(id)
            ON DELETE CASCADE
);
