CREATE TABLE property_images (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    property_id BIGINT NOT NULL,

    image_url TEXT NOT NULL,
    is_thumbnail BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_image_property
        FOREIGN KEY (property_id)
            REFERENCES properties(id)
            ON DELETE CASCADE
);
