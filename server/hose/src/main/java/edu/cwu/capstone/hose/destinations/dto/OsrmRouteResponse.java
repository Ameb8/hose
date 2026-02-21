package edu.cwu.capstone.hose.destinations.dto;

import lombok.Data;
import java.util.List;

@Data
public class OsrmRouteResponse {

    private List<Route> routes;

    @Data
    public static class Route {
        private Double distance;
        private Double duration;
        private Geometry geometry;
    }

    @Data
    public static class Geometry {
        private String type;
        private List<List<Double>> coordinates;
    }
}