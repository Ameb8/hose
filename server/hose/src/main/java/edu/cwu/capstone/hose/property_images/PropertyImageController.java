package edu.cwu.capstone.hose.property_images;


import edu.cwu.capstone.hose.property_images.dto.PropertyImageDTO;

import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestHeader;

@RestController
@RequestMapping("/properties/{propertyId}/images")
public class PropertyImageController {

    private final PropertyImageService service;

    @Value("${ADMIN_KEY}")
    private String validApiKey;

    public PropertyImageController(PropertyImageService service) {
        this.service = service;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<PropertyImageDTO> uploadImage(
        @PathVariable Long propertyId,
        @RequestPart("file") MultipartFile file,
        @RequestParam(defaultValue = "false") boolean isThumbnail,
        @RequestHeader(value = "X-API-Key", required = false) String key
    ) {
        if(!isValidKey(key))
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        PropertyImageDTO dto =
                service.uploadPropertyImage(propertyId, file, isThumbnail);

        return ResponseEntity.ok(dto);
    }

    private boolean isValidKey(String key) {
        return key != null && validApiKey.equals(key);
    }
}
