package edu.cwu.capstone.hose.destinations;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

public enum DestinationType {
    PROPERTY,
    CWU,
    BUS_STOP,
    OTHER
}

@Converter(autoApply = true)
class DestinationTypeConverter implements AttributeConverter<DestinationType, String> {

    // Store column as lowercase
    @Override
    public String convertToDatabaseColumn(DestinationType attribute) {
        if (attribute == null) return null;
        return attribute.name().toLowerCase();
    }

    // Process column as uppercase
    @Override
    public DestinationType convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return DestinationType.valueOf(dbData.toUpperCase());
    }
}
