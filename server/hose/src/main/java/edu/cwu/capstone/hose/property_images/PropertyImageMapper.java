package edu.cwu.capstone.hose.property_images;

import edu.cwu.capstone.hose.property_images.dto.PropertyImageDTO;

import org.mapstruct.*;

import java.util.List;
import java.util.Set;


@Mapper(componentModel = "spring")
public interface PropertyImageMapper {
    @Mapping(target = "isThumbnail", source = "thumbnail")
    PropertyImageDTO toDTO(PropertyImage image);
    List<PropertyImageDTO> toDTOs(Set<PropertyImage> images);
}
