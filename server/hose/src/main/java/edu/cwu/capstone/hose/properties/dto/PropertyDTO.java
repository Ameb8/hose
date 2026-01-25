package edu.cwu.capstone.hose.properties.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PropertyDTO {
    private Long id;
    private String name;
    private String propertyType;
    private String description;
    private String contactPhone;
    private String contactEmail;
}
