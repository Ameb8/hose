package edu.cwu.capstone.hose.property_images;

import edu.cwu.capstone.hose.properties.Property;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "property_images")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PropertyImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "property_id")
    private Property property;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;

    @Column(name = "is_thumbnail", nullable = false)
    private boolean isThumbnail;
}
