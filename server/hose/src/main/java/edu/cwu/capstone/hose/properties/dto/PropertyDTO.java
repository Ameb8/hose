package edu.cwu.capstone.hose.properties.dto;

import java.util.List;

import edu.cwu.capstone.hose.unit_types.dto.UnitTypeDTO;
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
    private List<UnitTypeDTO> unitTypes;
}
