package edu.cwu.capstone.hose.destinations;


import edu.cwu.capstone.hose.destinations.DestinationRepository;
import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import edu.cwu.capstone.hose.destinations.GeoJsonMapper;
import edu.cwu.capstone.hose.properties.PropertyRepository;
import edu.cwu.capstone.hose.properties.PropertyMapper;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DestinationService {

    private final DestinationRepository destinationRepository;
    private final DestinationMapper destinationMapper;

    public DestinationService(DestinationRepository destinationRepository,
                              DestinationMapper destinationMapper) {
        this.destinationRepository = destinationRepository;
        this.destinationMapper = destinationMapper;
    }

    public Map<String, Object> getGeoJson() {
        List<DestinationDTO> destinations = destinationMapper.toDTOs(
                destinationRepository.findAllWithAddressAndProperty()
        );

        return GeoJsonMapper.toFeatureCollection(destinations);
    }
}


