package edu.cwu.capstone.hose.destinations.dto;

import edu.cwu.capstone.hose.addresses.Address;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class DestinationDTO {
    private Long id;
    private String name;
    private String type;
    private String description;
    private Double latitude;
    private Double longitude;
    private Address address;
    private PropertySummaryDTO property;
}
