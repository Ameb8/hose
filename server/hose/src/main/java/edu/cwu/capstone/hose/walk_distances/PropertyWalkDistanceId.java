package edu.cwu.capstone.hose.walk_distances;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Embeddable
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class PropertyWalkDistanceId implements Serializable {

    @Column(name = "property_id")
    private Long propertyId;

    @Column(name = "destination_id")
    private Long destinationId;
}
