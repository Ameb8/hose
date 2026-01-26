package edu.cwu.capstone.hose.unit_types;

import edu.cwu.capstone.hose.unit_types.dto.UnitTypeDTO;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UnitTypeMapper {
    UnitTypeDTO toDTO(UnitType unitType);
}
