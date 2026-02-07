package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.Property;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface PropertyRepository extends JpaRepository<Property, Long> {
    @Query("""
        SELECT DISTINCT p
        FROM Property p
        LEFT JOIN FETCH p.unitTypes
        LEFT JOIN FETCH p.walkDistances wd
        LEFT JOIN FETCH wd.destination d
        LEFT JOIN FETCH p.images
        WHERE p.id = :id
    """)
    Optional<Property> findByIdFullPropertyData(@Param("id") Long id);
}