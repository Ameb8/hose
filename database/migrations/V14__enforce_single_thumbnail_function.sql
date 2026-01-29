CREATE OR REPLACE FUNCTION enforce_single_thumbnail()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.is_thumbnail THEN
        UPDATE property_images
        SET is_thumbnail = FALSE
        WHERE property_id = NEW.property_id
          AND id <> COALESCE(NEW.id, -1)
          AND is_thumbnail = TRUE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;