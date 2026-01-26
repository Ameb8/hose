package edu.cwu.capstone.hose.unit_types.dto;

import lombok.*;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UnitTypeDTO {
    private Long id;
    private String name;
    private int bedrooms;
    private int bathrooms;
    private int rentCents;
    private LocalDate availabilityDate;
    private Integer totalUnits;
    private Integer availableUnits;
    private String description;
}
