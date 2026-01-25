package edu.cwu.capstone.hose.destinations;

import edu.cwu.capstone.hose.destinations.DestinationRepository;
import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import edu.cwu.capstone.hose.properties.PropertyRepository;
import edu.cwu.capstone.hose.properties.PropertyMapper;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DestinationService {

    private final DestinationRepository destinationRepository;
    private final PropertyMapper propertyMapper;

    public DestinationService(DestinationRepository destinationRepository,
                              PropertyMapper propertyMapper) {
        this.destinationRepository = destinationRepository;
        this.propertyMapper = propertyMapper;
    }

    public List<DestinationDTO> getAllDestinations() {
        List<Destination> destinations = destinationRepository.findAllWithAddressAndProperty();

        return destinations.stream().map(destination -> {
            DestinationDTO dto = DestinationDTO.builder()
                    .id(destination.getId())
                    .name(destination.getName())
                    .type(destination.getType().name())
                    .description(destination.getDescription())
                    .latitude(destination.getLatitude())
                    .longitude(destination.getLongitude())
                    .address(destination.getAddress())
                    .build();

            // Map property if exists
            if(destination.getProperty() != null)
                dto.setProperty(propertyMapper.toSummaryDTO(destination.getProperty()));
            
            return dto;
        }).toList();
    }
}


