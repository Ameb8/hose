package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.destinations.Destination;
import edu.cwu.capstone.hose.property_images.PropertyImage;
import edu.cwu.capstone.hose.unit_types.UnitType;
import edu.cwu.capstone.hose.walk_distances.PropertyWalkDistance;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "properties")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Property {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Convert(converter = PropertyTypeConverter.class)
    @Column(name = "property_type", nullable = false)
    private PropertyType propertyType;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "contact_phone")
    private String contactPhone;

    @Column(name = "contact_email")
    private String contactEmail;

    @OneToOne(fetch = FetchType.LAZY, optional = false, cascade = CascadeType.ALL)
    @JoinColumn(name = "destination_id", nullable = false, unique = true)
    private Destination destination;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToMany(
        mappedBy = "property",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    private Set<UnitType> unitTypes;

    @OneToMany(
        mappedBy = "property",
        fetch = FetchType.LAZY,
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    private Set<PropertyWalkDistance> walkDistances;

    @OneToMany(
        mappedBy = "property",
        cascade = CascadeType.ALL,
        orphanRemoval = true
    )
    @Builder.Default
    private Set<PropertyImage> images = new HashSet<>();


}
