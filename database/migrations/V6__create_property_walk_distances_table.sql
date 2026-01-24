CREATE TABLE property_walk_distances (
    property_id BIGINT NOT NULL,
    destination_id BIGINT NOT NULL,

    walking_miles DECIMAL(4,2),
    walking_minutes INT,

    PRIMARY KEY (property_id, destination_id),

    CONSTRAINT fk_walk_property
        FOREIGN KEY (property_id)
            REFERENCES properties(id)
            ON DELETE CASCADE,

    CONSTRAINT fk_walk_destination
        FOREIGN KEY (destination_id)
            REFERENCES destinations(id)
            ON DELETE CASCADE
);
