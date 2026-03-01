package edu.cwu.capstone.hose.routing;

import edu.cwu.capstone.hose.destinations.dto.OsrmRouteResponse;
import edu.cwu.capstone.hose.destinations.dto.RouteResponseDTO;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

@Service
public class RoutingService {

    private final WebClient walkClient;
    private final WebClient carClient;
    private final WebClient bikeClient;

    public RoutingService(
            @Qualifier("osrmWalkClient") WebClient walkClient,
            @Qualifier("osrmCarClient") WebClient carClient,
            @Qualifier("osrmBikeClient") WebClient bikeClient
    ) {
        this.walkClient = walkClient;
        this.carClient = carClient;
        this.bikeClient = bikeClient;
    }

    public RouteResponseDTO getRoute(
            double fromLat,
            double fromLon,
            double toLat,
            double toLon,
            RoutingProfile profile
    ) {
        String coordinates = String.format("%f,%f;%f,%f", fromLon, fromLat, toLon, toLat);

        WebClient client = getClientForProfile(profile);

        OsrmRouteResponse osrmResponse = client.get()
                .uri(uriBuilder -> uriBuilder
                        .path("/route/v1/{profile}/{coords}")
                        .queryParam("overview", "full")
                        .queryParam("geometries", "geojson")
                        .build(profile.getOsrmProfile(), coordinates))
                .retrieve()
                .bodyToMono(OsrmRouteResponse.class)
                .retry(2)
                .block();

        if (osrmResponse == null || osrmResponse.getRoutes() == null || osrmResponse.getRoutes().isEmpty()) {
            throw new RuntimeException("No route returned from OSRM");
        }

        OsrmRouteResponse.Route route = osrmResponse.getRoutes().get(0);

        RouteResponseDTO response = new RouteResponseDTO();
        response.setDistance(route.getDistance());
        response.setDuration(route.getDuration());
        response.setGeometry(route.getGeometry());

        return response;
    }

    private WebClient getClientForProfile(RoutingProfile profile) {
        return switch (profile) {
            case CAR -> carClient;
            case BIKE -> bikeClient;
            case WALK -> walkClient;
        };
    }
}