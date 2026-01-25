package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.Property;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PropertyRepository extends JpaRepository<Property, Long> { }