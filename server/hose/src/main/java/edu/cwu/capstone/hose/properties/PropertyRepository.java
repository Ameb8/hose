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
        SELECT p
        FROM Property p
        LEFT JOIN FETCH p.unitTypes
        WHERE p.id = :id
    """)
    Optional<Property> findByIdWithUnitTypes(@Param("id") Long id);
}