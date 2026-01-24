CREATE TABLE lease_agreements (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    property_id BIGINT NOT NULL UNIQUE,

    lease_type TEXT,
    start_month TEXT,
    early_termination_fee_cents INT,

    CONSTRAINT fk_lease_property
        FOREIGN KEY (property_id)
            REFERENCES properties(id)
            ON DELETE CASCADE
);
