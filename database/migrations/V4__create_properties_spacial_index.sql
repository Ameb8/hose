-- Create index to efficiently query properties spatially
-- Allows searching properties within coordinate-based rectangle
CREATE INDEX idx_properties_coordinates
    ON properties
    USING GIST(coordinates)
;
