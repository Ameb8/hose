package edu.cwu.capstone.hose.destinations;

import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;
import edu.cwu.capstone.hose.properties.PropertyMapper;

import org.mapstruct.*;

import java.util.List;


@Mapper(
    componentModel = "spring",
    uses = PropertyMapper.class,
    unmappedTargetPolicy = ReportingPolicy.ERROR
)
public interface DestinationMapper {

    @Mapping(target = "type", expression = "java(destination.getType().name())")
    @Mapping(target = "property", source = "property")
    DestinationDTO toDTO(Destination destination);

    List<DestinationDTO> toDTOs(List<Destination> destinations);
}
