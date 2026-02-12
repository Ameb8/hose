package edu.cwu.capstone.hose.properties.dto;


import edu.cwu.capstone.hose.property_images.dto.PropertyImageDTO;
import edu.cwu.capstone.hose.unit_types.dto.UnitTypeDTO;
import edu.cwu.capstone.hose.walk_distances.dto.WalkDistanceDTO;

import lombok.*;

import java.util.List;


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
    private List<UnitTypeDTO> unitTypes;
    private List<WalkDistanceDTO> busStopWalkDistances;
    private List<PropertyImageDTO> images;
}
