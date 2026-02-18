package edu.cwu.capstone.hose.destinations;

import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;
import edu.cwu.capstone.hose.unit_types.dto.UnitTypeDTO;

import java.util.*;
import java.util.stream.Collectors;

public class GeoJsonMapper {

    /** Converts a list of DestinationDTOs into a GeoJSON FeatureCollection */
    public static Map<String, Object> toFeatureCollection(List<DestinationDTO> destinations) {
        List<Map<String, Object>> features = destinations.stream()
                .map(GeoJsonMapper::toFeature)
                .collect(Collectors.toList());

        Map<String, Object> featureCollection = new HashMap<>();
        featureCollection.put("type", "FeatureCollection");
        featureCollection.put("features", features);

        return featureCollection;
    }

    /** Converts a single DestinationDTO into a GeoJSON Feature object */
    private static Map<String, Object> toFeature(DestinationDTO destination) {
        Map<String, Object> feature = new HashMap<>();
        feature.put("type", "Feature");
        feature.put("id", destination.getId());

        // Geometry
        Map<String, Object> geometry = new HashMap<>();
        geometry.put("type", "Point");
        geometry.put("coordinates", new double[]{destination.getLongitude(), destination.getLatitude()});
        feature.put("geometry", geometry);

        // Properties
        Map<String, Object> properties = new HashMap<>();
        properties.put("id", destination.getId());
        properties.put("name", destination.getName());
        properties.put("type", destination.getType());
        properties.put("description", destination.getDescription() != null ? destination.getDescription() : "");
        properties.put("address", destination.getAddress() != null ? destination.getAddress().toString() : "");

        if ("PROPERTY".equals(destination.getType()) && destination.getProperty() != null)
            properties.put("property", toProperty(destination.getProperty()));

        feature.put("properties", properties);
        return feature;
    }

    /** Converts a PropertySummaryDTO into a JSON-friendly map */
    private static Map<String, Object> toProperty(PropertySummaryDTO property) {
        Map<String, Object> propMap = new HashMap<>();
        propMap.put("id", property.getId());
        propMap.put("name", property.getName());
        propMap.put("type", property.getPropertyType());
        propMap.put("description", property.getDescription());
        propMap.put("contact_phone", property.getContactPhone());
        propMap.put("contact_email", property.getContactEmail());

        if (property.getUnitTypes() != null) {
            List<Map<String, Object>> unitTypes = property.getUnitTypes().stream()
                    .map(GeoJsonMapper::toUnitType)
                    .collect(Collectors.toList());
            propMap.put("unit_types", unitTypes);
        }

        return propMap;
    }

    /** Converts a UnitTypeDTO into a JSON-friendly map */
    private static Map<String, Object> toUnitType(UnitTypeDTO unitType) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", unitType.getId());
        map.put("name", unitType.getName());
        map.put("bedrooms", unitType.getBedrooms());
        map.put("bathrooms", unitType.getBathrooms());
        map.put("rent", unitType.getRentCents());
        map.put("total_units", unitType.getTotalUnits());
        map.put("available_units", unitType.getAvailableUnits());
        map.put("description", unitType.getDescription());
        return map;
    }
}
