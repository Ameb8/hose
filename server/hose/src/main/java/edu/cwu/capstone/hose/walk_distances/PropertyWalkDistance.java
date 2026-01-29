package edu.cwu.capstone.hose.walk_distances;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "property_walk_distances")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class PropertyWalkDistance {

    @EmbeddedId
    private PropertyWalkDistanceId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("propertyId")
    @JoinColumn(name = "property_id")
    private Property property;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("destinationId")
    @JoinColumn(name = "destination_id")
    private Destination destination;

    @Column(name = "walking_miles", precision = 4, scale = 2)
    private BigDecimal walkingMiles;

    @Column(name = "walking_minutes")
    private Integer walkingMinutes;
}
