package edu.cwu.capstone.hose.properties.dto;


import edu.cwu.capstone.hose.unit_types.dto.CreateUnitTypeRequest;

import lombok.Data;

import java.util.List;


@Data
public class CreatePropertyRequest {

    // Property fields
    private String name;
    private String propertyType; 
    private String description;
    private String contactPhone;
    private String contactEmail;

    // Location
    private Double latitude;
    private Double longitude;

    // Address fields
    private String street;
    private String city;
    private String state;
    private String zip;

    // Unit Types
    private List<CreateUnitTypeRequest> unitTypes;
}
