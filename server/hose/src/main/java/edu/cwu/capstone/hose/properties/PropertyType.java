package edu.cwu.capstone.hose.properties;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

public enum PropertyType {
    APARTMENT,
    DORM,
    HOUSE
}

@Converter(autoApply = true)
class PropertyTypeConverter implements AttributeConverter<PropertyType, String> {

    // Store column as lowercase
    @Override
    public String convertToDatabaseColumn(PropertyType attribute) {
        if (attribute == null) return null;
        return attribute.name().toLowerCase();
    }

    // Process column as uppercase
    @Override
    public PropertyType convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return PropertyType.valueOf(dbData.toUpperCase());
    }
}
