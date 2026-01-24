CREATE TABLE lease_rules (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    rule_text TEXT NOT NULL,
    category TEXT, -- termination | sublease | occupancy | fees
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);
