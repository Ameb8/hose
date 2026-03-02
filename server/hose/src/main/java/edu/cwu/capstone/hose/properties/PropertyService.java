package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.addresses.Address;
import edu.cwu.capstone.hose.destinations.Destination;
import edu.cwu.capstone.hose.destinations.DestinationRepository;
import edu.cwu.capstone.hose.properties.PropertyType;
import edu.cwu.capstone.hose.properties.PropertyMapper;
import edu.cwu.capstone.hose.destinations.DestinationType;
import edu.cwu.capstone.hose.properties.Property;
import edu.cwu.capstone.hose.properties.PropertyRepository;
import edu.cwu.capstone.hose.properties.dto.CreatePropertyRequest;
import edu.cwu.capstone.hose.properties.dto.PropertyDTO;
import edu.cwu.capstone.hose.unit_types.UnitType;
import edu.cwu.capstone.hose.routing.RoutingService;
import edu.cwu.capstone.hose.routing.dto.DistanceDTO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Set;

@Service
public class PropertyService {

    private final PropertyRepository propertyRepository;
    private final PropertyMapper propertyMapper;
    private final DestinationRepository destinationRepository;
    private final RoutingService routingService;

    public PropertyService(PropertyRepository repository, PropertyMapper mapper, DestinationRepository destinationRepository, RoutingService routingService) {
        this.propertyRepository = repository;
        this.propertyMapper = mapper;
        this.destinationRepository = destinationRepository;
        this.routingService = routingService;
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

        // Set field on destination object
        destination.setProperty(property);

        if (req.getUnitTypes() != null && !req.getUnitTypes().isEmpty()) {
        Set<UnitType> units = req.getUnitTypes().stream()
            .map(ut -> UnitType.builder()
                .property(property)
                .name(ut.getName())
                .bedrooms(ut.getBedrooms())
                .bathrooms(ut.getBathrooms())
                .rentCents(ut.getRentCents())
                .availabilityDate(ut.getAvailabilityDate())
                .totalUnits(ut.getTotalUnits())
                .availableUnits(ut.getAvailableUnits())
                .description(ut.getDescription())
                .build()
            )
            .collect(Collectors.toSet());

        property.setUnitTypes(units);
    }


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


    public Boolean calcNearestAll() {
        List<Property> properties = propertyRepository.findAll();
        Boolean success = true;


        for(Property property : properties) {
            if(!nearestPOIProperty(property, DestinationType.CWU))
                success = false;
            if(!nearestPOIProperty(property, DestinationType.BUS_STOP))
                success = false;
        }

        return success;
    }


    public Boolean nearestCWU(Long id) {
        return nearestPOI(id, DestinationType.CWU);
    }


    public Boolean nearestBusStop(Long id) {
        return nearestPOI(id, DestinationType.BUS_STOP);
    }


    public Boolean nearestPOI(Long id, DestinationType type) {
        Optional<Property> optProperty = propertyRepository.findById(id);

        if(optProperty.isEmpty())
            return false;

        Property property = optProperty.get();

        return nearestPOIProperty(property, type);
    }

    @Transactional
    public Boolean nearestPOIProperty(Property property, DestinationType type) {
        List<Destination> stops = destinationRepository.findByType(type);

        double minDistance = Double.MAX_VALUE;
        double minTime = Double.MAX_VALUE;

        Destination dest = property.getDestination();
        double sourceLat = dest.getLatitude();
        double sourceLong = dest.getLongitude();

        for(Destination stop : stops) {
            DistanceDTO distance = routingService.getWalkRating(sourceLat, sourceLong, stop.getLatitude(), stop.getLongitude());

            if(distance.getDistance() < minDistance) {
                minDistance = distance.getDistance();
                minTime = distance.getDuration();
            }
        }

        BigDecimal miles = BigDecimal
            .valueOf(minDistance)
            .divide(BigDecimal.valueOf(1609.344), 2, RoundingMode.HALF_UP);

        if(type == DestinationType.BUS_STOP) {
            property.setBusStopMins((int) Math.round(minTime / 60.0));
            property.setBusStopDistance(miles);
        } else if (type == DestinationType.CWU) {
            property.setCwuMins((int) Math.round(minTime / 60.0));
            property.setCwuDistance(miles);
        }

        propertyRepository.save(property);

        return true;
    }
}
