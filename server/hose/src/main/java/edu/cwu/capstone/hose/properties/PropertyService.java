package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.Property;
import edu.cwu.capstone.hose.properties.PropertyRepository;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PropertyService {

    private final PropertyRepository repository;

    public PropertyService(PropertyRepository repository) {
        this.repository = repository;
    }

    public List<Property> getAllProperties() {
        return repository.findAll();
    }

    public Optional<Property> getPropertyById(Long id) {
        return repository.findById(id);
    }

    public Property createProperty(Property property) {
        return repository.save(property);
    }

    public Property updateProperty(Long id, Property updatedProperty) {
        return repository.findById(id)
                .map(property -> {
                    property.setName(updatedProperty.getName());
                    property.setPropertyType(updatedProperty.getPropertyType());
                    property.setDescription(updatedProperty.getDescription());
                    property.setContactPhone(updatedProperty.getContactPhone());
                    property.setContactEmail(updatedProperty.getContactEmail());
                    //property.setAddressId(updatedProperty.getAddressId());
                    //property.setDestinationId(updatedProperty.getDestinationId());
                    return repository.save(property);
                })
                .orElseThrow(() -> new RuntimeException("Property not found with id " + id));
    }

    public void deleteProperty(Long id) {
        repository.deleteById(id);
    }
}
