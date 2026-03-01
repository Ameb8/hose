package edu.cwu.capstone.hose.destinations;


import edu.cwu.capstone.hose.destinations.DestinationRepository;
import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import edu.cwu.capstone.hose.destinations.GeoJsonMapper;
import edu.cwu.capstone.hose.destinations.dto.OsrmRouteResponse;
import edu.cwu.capstone.hose.destinations.dto.RouteRequestDTO;
import edu.cwu.capstone.hose.destinations.dto.RouteResponseDTO;
import edu.cwu.capstone.hose.properties.PropertyRepository;
import edu.cwu.capstone.hose.properties.PropertyMapper;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;
import edu.cwu.capstone.hose.routing.RoutingProfile;
import edu.cwu.capstone.hose.routing.RoutingService;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DestinationService {

    private final DestinationRepository destinationRepository;
    private final DestinationMapper destinationMapper;
    private final RoutingService routingService;

    public DestinationService(DestinationRepository destinationRepository,
                              DestinationMapper destinationMapper,
                              RoutingService routingService) {
        this.destinationRepository = destinationRepository;
        this.destinationMapper = destinationMapper;
        this.routingService = routingService;
    }


    public Map<String, Object> getGeoJson() {
        List<DestinationDTO> destinations = destinationMapper.toDTOs(
                destinationRepository.findAllWithAddressAndProperty()
        );

        return GeoJsonMapper.toFeatureCollection(destinations);
    }

    public RouteResponseDTO getRouteBetween(Long fromId, Long toId, RoutingProfile profile) {
        Destination from = destinationRepository.findById(fromId)
                .orElseThrow(() -> new RuntimeException("From destination not found"));

        Destination to = destinationRepository.findById(toId)
                .orElseThrow(() -> new RuntimeException("To destination not found"));

        // Delegate routing to RoutingService
        return routingService.getRoute(
                from.getLatitude(),
                from.getLongitude(),
                to.getLatitude(),
                to.getLongitude(),
                profile
        );
    }
}


