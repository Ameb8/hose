CREATE TRIGGER trg_single_thumbnail
BEFORE INSERT OR UPDATE ON property_images
FOR EACH ROW
EXECUTE FUNCTION enforce_single_thumbnail();
