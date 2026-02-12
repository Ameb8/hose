package edu.cwu.capstone.hose.unit_types.dto;

import lombok.Data;
import java.time.LocalDate;

@Data
public class CreateUnitTypeRequest {
    private String name;
    private int bedrooms;
    private int bathrooms;
    private int rentCents;
    private LocalDate availabilityDate;
    private Integer totalUnits;
    private Integer availableUnits;
    private String description;
}
