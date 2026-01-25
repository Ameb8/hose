package edu.cwu.capstone.hose.destinations;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DestinationRepository extends JpaRepository<Destination, Long> {

    @Query("""
           SELECT d 
           FROM Destination d
           LEFT JOIN FETCH d.address
           LEFT JOIN FETCH d.property
           """)
    List<Destination> findAllWithAddressAndProperty();
}
