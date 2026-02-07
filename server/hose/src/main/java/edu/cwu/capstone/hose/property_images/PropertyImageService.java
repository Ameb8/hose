package edu.cwu.capstone.hose.property_images;

import edu.cwu.capstone.hose.property_images.PropertyImageRepository;
import edu.cwu.capstone.hose.property_images.dto.PropertyImageDTO;
import edu.cwu.capstone.hose.properties.Property;
import edu.cwu.capstone.hose.properties.PropertyRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


@Service
@Transactional
public class PropertyImageService {

    private final PropertyRepository propertyRepository;
    private final PropertyImageRepository imageRepository;
    private final PropertyImageMapper mapper;
    private final CloudinaryService cloudinary;

    public PropertyImageService(
        PropertyRepository propertyRepository,
        PropertyImageRepository imageRepository,
        PropertyImageMapper mapper,
        CloudinaryService cloudinary
    ) {
        this.propertyRepository = propertyRepository;
        this.imageRepository = imageRepository;
        this.mapper = mapper;
        this.cloudinary = cloudinary;
    }

    public PropertyImageDTO uploadPropertyImage(
        Long propertyId,
        MultipartFile file,
        boolean isThumbnail
    ) {
        Property property = propertyRepository.findById(propertyId)
            .orElseThrow(() -> new RuntimeException("Property not found"));

        if (isThumbnail) {
            property.getImages()
                .forEach(img -> img.setThumbnail(false));
        }

        String url = cloudinary.uploadPropertyImage(file, propertyId);

        PropertyImage image = PropertyImage.builder()
            .property(property)
            .imageUrl(url)
            .isThumbnail(isThumbnail)
            .build();

        property.getImages().add(image);

        return mapper.toDTO(imageRepository.save(image));
    }
}
