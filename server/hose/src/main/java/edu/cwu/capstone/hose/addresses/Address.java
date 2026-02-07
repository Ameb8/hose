package edu.cwu.capstone.hose.addresses;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "addresses")
@Getter 
@Setter
@NoArgsConstructor 
@AllArgsConstructor 
@Builder
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String streetAddress;

    @Column(nullable = false)
    private String city;

    @Column(nullable = false)
    private String state;

    @Column(nullable = false)
    private String postalCode;

    @Builder.Default
    @Column(nullable = false)
    private String country = "USA";

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Override
    public String toString() {
        return String.join(", ",
                streetAddress != null ? streetAddress : "",
                city != null ? city : "",
                state != null ? state : "",
                postalCode != null ? postalCode : "").replaceAll(", $", "");
    }
}
