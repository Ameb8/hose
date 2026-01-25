package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.dto.*;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring")
public interface PropertyMapper {

    // Full object (GET by PK)
    @Mapping(target = "propertyType",
             expression = "java(property.getPropertyType().name())")
    PropertyDTO toDTO(Property property);

    // Summary (GET all)
    @Mapping(target = "propertyType",
             expression = "java(property.getPropertyType().name())")
    PropertySummaryDTO toSummaryDTO(Property property);

    // Collection mapping (automatic loop)
    List<PropertySummaryDTO> toSummaryDTOs(List<Property> properties);
}
