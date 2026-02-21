package edu.cwu.capstone.hose.destinations.dto;

import lombok.*;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class RouteRequestDTO {
    private Double fromLat;
    private Double fromLon;
    private Double toLat;
    private Double toLon;
}
