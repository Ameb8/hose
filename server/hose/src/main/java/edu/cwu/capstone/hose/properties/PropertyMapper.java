package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.dto.*;
import edu.cwu.capstone.hose.unit_types.UnitTypeMapper;
import edu.cwu.capstone.hose.property_images.PropertyImageMapper;

import org.mapstruct.*;

import java.util.List;


@Mapper(
    componentModel = "spring",
    uses = {
        UnitTypeMapper.class,
        PropertyImageMapper.class
    },
    unmappedTargetPolicy = ReportingPolicy.ERROR
)
public interface PropertyMapper {

    // Full object (GET by PK)
    @Mapping(
        target = "busStopWalkDistances",
        expression = """
            java(
            property.getWalkDistances() == null ? List.of() :
            property.getWalkDistances().stream()
                .filter(wd -> wd.getDestination() != null)
                .map(wd -> edu.cwu.capstone.hose.walk_distances.dto.WalkDistanceDTO.builder()
                    .destinationId(wd.getDestination().getId())
                    .destinationName(wd.getDestination().getName())
                    .walkingMiles(wd.getWalkingMiles())
                    .walkingMinutes(wd.getWalkingMinutes())
                    .build()
                )
                .toList()
            )
        """
    )
    @Mapping(
        target = "address",
        expression = """
            java(
                property.getDestination() != null &&
                property.getDestination().getAddress() != null
                    ? property.getDestination().getAddress().toString()
                    : null
            )
        """
    )
    @Mapping(target = "propertyType",
             expression = "java(property.getPropertyType().name())")
    @Mapping(target = "images", source = "images")
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
    @Mapping(target = "walkDistances", ignore = true)
    @Mapping(target = "images", ignore = true)
    void updatePropertyFromDTO(PropertyDTO dto, @MappingTarget Property entity);

}
