CREATE TABLE lease_agreement_rules (
    lease_agreement_id BIGINT NOT NULL,
    lease_rule_id BIGINT NOT NULL,

    PRIMARY KEY (lease_agreement_id, lease_rule_id),

    CONSTRAINT fk_lar_lease_agreement
        FOREIGN KEY (lease_agreement_id)
            REFERENCES lease_agreements(id)
            ON DELETE CASCADE,

    CONSTRAINT fk_lar_lease_rule
        FOREIGN KEY (lease_rule_id)
            REFERENCES lease_rules(id)
            ON DELETE CASCADE
);
