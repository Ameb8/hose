package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.dto.*;
import edu.cwu.capstone.hose.unit_types.UnitTypeMapper;

import org.mapstruct.*;

import java.util.List;


@Mapper(
    componentModel = "spring",
    uses = UnitTypeMapper.class,
    unmappedTargetPolicy = ReportingPolicy.ERROR
)
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

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(target = "destination", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "unitTypes", ignore = true)
    void updatePropertyFromDTO(PropertyDTO dto, @MappingTarget Property entity);
}
