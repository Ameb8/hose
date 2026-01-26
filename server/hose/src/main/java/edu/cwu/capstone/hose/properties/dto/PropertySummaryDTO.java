package edu.cwu.capstone.hose.properties.dto;

import edu.cwu.capstone.hose.unit_types.dto.UnitTypeDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


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
    private List<UnitTypeDTO> unitTypes;
}