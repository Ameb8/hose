CREATE TABLE property_pet_rules (
    property_id BIGINT NOT NULL,
    pet_rule_id BIGINT NOT NULL,

    PRIMARY KEY (property_id, pet_rule_id),

    CONSTRAINT fk_ppr_property
        FOREIGN KEY (property_id)
            REFERENCES properties(id)
            ON DELETE CASCADE,

    CONSTRAINT fk_ppr_pet_rule
        FOREIGN KEY (pet_rule_id)
            REFERENCES pet_rules(id)
            ON DELETE CASCADE
);
