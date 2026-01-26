package edu.cwu.capstone.hose.unit_types;

import edu.cwu.capstone.hose.properties.Property;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "unit_types")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UnitType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "property_id", nullable = false)
    private Property property;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private int bedrooms;

    @Column(nullable = false)
    private int bathrooms;

    @Column(name = "rent_cents", nullable = false)
    private int rentCents;

    @Column(name = "availability_date")
    private LocalDate availabilityDate;

    @Column(name = "total_units")
    private Integer totalUnits;

    @Column(name = "available_units")
    private Integer availableUnits;

    @Column(columnDefinition = "TEXT")
    private String description;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
