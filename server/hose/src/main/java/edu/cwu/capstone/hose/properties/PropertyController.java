
package edu.cwu.capstone.hose.properties;

import edu.cwu.capstone.hose.properties.PropertyService;
import edu.cwu.capstone.hose.properties.PropertyMapper;
import edu.cwu.capstone.hose.properties.dto.CreatePropertyRequest;
import edu.cwu.capstone.hose.properties.dto.PropertyDTO;
import edu.cwu.capstone.hose.properties.dto.PropertySummaryDTO;

import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

@RestController
@RequestMapping("/properties")
public class PropertyController {

    private final PropertyService service;
    private final PropertyMapper mapper;

    @Value("${ADMIN_KEY}")
    private String validApiKey;

    public PropertyController(PropertyService service, PropertyMapper mapper) {
        this.service = service;
        this.mapper = mapper;
    }

    @GetMapping
    public List<PropertySummaryDTO> getAllProperties() {
        return mapper.toSummaryDTOs(service.getAllProperties());
    }

    @GetMapping("/{id}")
    public ResponseEntity<PropertyDTO> getProperty(@PathVariable Long id) {
        return service.getPropertyById(id)
                .map(p -> ResponseEntity.ok(mapper.toDTO(p)))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<PropertyDTO> createProperty(
            @RequestBody CreatePropertyRequest request,
            @RequestHeader(value = "X-API-Key", required = false) String key
    ) {
        if(!isValidKey(key)) // Validate API-Key
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();            

        // Attempt to create Property object
        Property property = service.createProperty(request);
        return ResponseEntity.ok(mapper.toDTO(property));
    }


    @PatchMapping("/stops")
    public ResponseEntity<Void> updateNearestAll(
            @PathVariable Long id,
            @RequestHeader(value = "X-API-Key", required = false) String key
    ) {
        if (!isValidKey(key)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        boolean success = service.calcNearestAll();

        if (success) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PatchMapping("/stops/{id}")
    public ResponseEntity<Void> updateNearest(
            @PathVariable Long id,
            @RequestHeader(value = "X-API-Key", required = false) String key
    ) {
        if (!isValidKey(key)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        boolean success = service.nearestBusStop(id);

        if (success) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    private boolean isValidKey(String key) {
        return key != null && validApiKey.equals(key);
    }
}
