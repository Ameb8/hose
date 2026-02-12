package edu.cwu.capstone.hose.property_images.dto;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PropertyImageDTO {
    private Long id;
    private String imageUrl;
    private boolean isThumbnail;
}
