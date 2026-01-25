package edu.cwu.capstone.hose.destinations;

import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;
import edu.cwu.capstone.hose.properties.PropertyMapper;

import org.mapstruct.*;

import java.util.List;


@Mapper(componentModel = "spring", uses = PropertyMapper.class)
public interface DestinationMapper {

    @Mapping(target = "type", expression = "java(destination.getType().name())")
    @Mapping(target = "property", expression = "java(mapProperty(destination))")
    DestinationDTO toDTO(Destination destination);

    List<DestinationDTO> toDTOs(List<Destination> destinations);

    default PropertySummaryDTO mapProperty(Destination destination) {
        if (destination == null || destination.getId() == null) return null;
        return destination.getProperty() != null ? null : null; 
    }
}
