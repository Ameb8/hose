package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.Property;
import edu.cwu.capstone.hose.properties.PropertyRepository;
import edu.cwu.capstone.hose.properties.dto.PropertyDTO;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PropertyService {

    private final PropertyRepository repository;
    private final PropertyMapper propertyMapper;

    public PropertyService(PropertyRepository repository, PropertyMapper mapper) {
        this.repository = repository;
        this.propertyMapper = mapper;
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

    public Property updateProperty(Long id, PropertyDTO dto) {
        return repository.findById(id)
                .map(property -> {
                    propertyMapper.updatePropertyFromDTO(dto, property);
                    return repository.save(property);
                })
                .orElseThrow(() -> new RuntimeException("Property not found with id " + id));
    }

    public void deleteProperty(Long id) {
        repository.deleteById(id);
    }
}
