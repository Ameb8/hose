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
    private final DestinationMapper destinationMapper;

    public DestinationService(DestinationRepository destinationRepository,
                              DestinationMapper destinationMapper) {
        this.destinationRepository = destinationRepository;
        this.destinationMapper = destinationMapper;
    }

    public List<DestinationDTO> getAllDestinations() {
        return destinationMapper.toDTOs(
                destinationRepository.findAllWithAddressAndProperty()
        );
    }
}


