package edu.cwu.capstone.hose.walk_distances.dto;

import lombok.*;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WalkDistanceDTO {
    private Long destinationId;
    private String destinationName;
    private BigDecimal walkingMiles;
    private Integer walkingMinutes;
}
