package edu.cwu.capstone.hose.destinations;

import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import edu.cwu.capstone.hose.destinations.GeoJsonMapper;

import edu.cwu.capstone.hose.destinations.dto.RouteResponseDTO;
import edu.cwu.capstone.hose.routing.RoutingProfile;

import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/destinations")
public class DestinationController {

    private final DestinationService service;

    public DestinationController(DestinationService service) {
        this.service = service;
    }

    @GetMapping
    public Map<String, Object> getAllDestinations() {
        return service.getGeoJson();
    }

    @GetMapping("/{fromId}/{toId}/route")
    public RouteResponseDTO getRouteBetween(
            @PathVariable Long fromId,
            @PathVariable Long toId,
            @RequestParam(defaultValue = "WALK") RoutingProfile profile
    ) {
        return service.getRouteBetween(fromId, toId, profile);
    }
}
