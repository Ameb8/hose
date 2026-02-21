package edu.cwu.capstone.hose.destinations.dto;

import lombok.*;


@Data
public class RouteResponseDTO {
    private Double distance;
    private Double duration;
    private OsrmRouteResponse.Geometry geometry;
}