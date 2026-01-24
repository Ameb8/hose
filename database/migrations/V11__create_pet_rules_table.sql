CREATE TABLE pet_rules (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    rule_text TEXT NOT NULL,
    category TEXT, -- breed | size | noise | quantity
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);
