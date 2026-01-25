package edu.cwu.capstone.hose.properties.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PropertySummaryDTO {
    private String name;
    private String propertyType;
    private String description;
    private String contactPhone;
    private String contactEmail;
    //private Address address;
    //private Destination destinationId;
}