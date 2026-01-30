package edu.cwu.capstone.hose.walk_distances;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PropertyWalkDistanceRepository
        extends JpaRepository<PropertyWalkDistance, PropertyWalkDistanceId> {
}
