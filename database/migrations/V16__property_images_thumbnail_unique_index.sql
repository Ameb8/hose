CREATE UNIQUE INDEX uq_property_thumbnail
ON property_images(property_id)
WHERE is_thumbnail = TRUE;