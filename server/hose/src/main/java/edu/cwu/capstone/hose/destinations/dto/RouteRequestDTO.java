package edu.cwu.capstone.hose.destinations.dto;

import edu.cwu.capstone.hose.routing.RoutingProfile;
import lombok.*;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class RouteRequestDTO {
    private Double fromLat;
    private Double fromLon;
    private Double toLat;
    private Double toLon;

    RoutingProfile profile;
}
