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

import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DestinationService {

    private final DestinationRepository destinationRepository;
    private final DestinationMapper destinationMapper;
    private final WebClient routeWebClient;

    public DestinationService(DestinationRepository destinationRepository,
                              DestinationMapper destinationMapper,
                              WebClient routeWebClient) {
        this.destinationRepository = destinationRepository;
        this.destinationMapper = destinationMapper;
        this.routeWebClient = routeWebClient;
    }

    public Map<String, Object> getGeoJson() {
        List<DestinationDTO> destinations = destinationMapper.toDTOs(
                destinationRepository.findAllWithAddressAndProperty()
        );

        return GeoJsonMapper.toFeatureCollection(destinations);
    }

    public RouteResponseDTO getRouteBetween(Long fromId, Long toId) {

        Destination from = destinationRepository.findById(fromId)
                .orElseThrow(() -> new RuntimeException("From destination not found"));

        Destination to = destinationRepository.findById(toId)
                .orElseThrow(() -> new RuntimeException("To destination not found"));

        String coordinates = String.format(
                "%f,%f;%f,%f",
                from.getLongitude(), from.getLatitude(),
                to.getLongitude(), to.getLatitude()
        );

        OsrmRouteResponse osrmResponse = routeWebClient.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/route/v1/walking/{coords}")
                        .queryParam("overview", "full")
                        .queryParam("geometries", "geojson")
                        .build(coordinates))
                .retrieve()
                .bodyToMono(OsrmRouteResponse.class)
                .retry(2)
                .block();

        if (osrmResponse == null ||
                osrmResponse.getRoutes() == null ||
                osrmResponse.getRoutes().isEmpty()) {
            throw new RuntimeException("No route returned from OSRM");
        }

        OsrmRouteResponse.Route route = osrmResponse.getRoutes().get(0);

        RouteResponseDTO response = new RouteResponseDTO();
        response.setDistance(route.getDistance());
        response.setDuration(route.getDuration());
        response.setGeometry(route.getGeometry());

        return response;
    }
}


