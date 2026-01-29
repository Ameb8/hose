package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.addresses.Address;
import edu.cwu.capstone.hose.destinations.Destination;
import edu.cwu.capstone.hose.properties.PropertyType;
import edu.cwu.capstone.hose.properties.PropertyMapper;
import edu.cwu.capstone.hose.destinations.DestinationType;
import edu.cwu.capstone.hose.properties.Property;
import edu.cwu.capstone.hose.properties.PropertyRepository;
import edu.cwu.capstone.hose.properties.dto.CreatePropertyRequest;
import edu.cwu.capstone.hose.properties.dto.PropertyDTO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;
import java.util.Optional;

@Service
public class PropertyService {

    private final PropertyRepository propertyRepository;
    private final PropertyMapper propertyMapper;

    public PropertyService(PropertyRepository repository, PropertyMapper mapper) {
        this.propertyRepository = repository;
        this.propertyMapper = mapper;
    }

    public List<Property> getAllProperties() {
        return propertyRepository.findAll();
    }

    public Optional<Property> getPropertyById(Long id) {
        return propertyRepository.findByIdFullPropertyData(id);
    }

    @Transactional
    public Property createProperty(CreatePropertyRequest req) {

        Address address = Address.builder()
            .streetAddress(req.getStreet())
            .city(req.getCity())
            .state(req.getState())
            .postalCode(req.getZip())
            .country("USA")
            .build();

        Destination destination = Destination.builder()
            .name(req.getName())
            .type(DestinationType.PROPERTY)
            .description(req.getDescription())
            .latitude(req.getLatitude())
            .longitude(req.getLongitude())
            .address(address)
            .build();

        Property property = Property.builder()
            .name(req.getName())
            .propertyType(PropertyType.valueOf(req.getPropertyType()))
            .description(req.getDescription())
            .contactPhone(req.getContactPhone())
            .contactEmail(req.getContactEmail())
            .destination(destination)
            .build();

        // bidirectional safety (optional but good)
        destination.setProperty(property);

        return propertyRepository.save(property);
    }

    public Property updateProperty(Long id, PropertyDTO dto) {
        return propertyRepository.findById(id)
                .map(property -> {
                    propertyMapper.updatePropertyFromDTO(dto, property);
                    return propertyRepository.save(property);
                })
                .orElseThrow(() -> new RuntimeException("Property not found with id " + id));
    }

    public void deleteProperty(Long id) {
        propertyRepository.deleteById(id);
    }
}
