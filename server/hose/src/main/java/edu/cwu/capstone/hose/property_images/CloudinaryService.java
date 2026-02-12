package edu.cwu.capstone.hose.property_images;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.UUID;

@Service
public class CloudinaryService {

    private final Cloudinary cloudinary;

    public CloudinaryService(Cloudinary cloudinary) {
        this.cloudinary = cloudinary;
    }

    public String uploadPropertyImage(MultipartFile file, Long propertyId) {
        try {
            Map<?, ?> result = cloudinary.uploader().upload(
                file.getBytes(),
                ObjectUtils.asMap(
                    "folder", "properties/" + propertyId,
                    "public_id", UUID.randomUUID().toString(),
                    "resource_type", "image"
                )
            );
            return (String) result.get("secure_url");
        } catch (Exception e) {
            throw new RuntimeException("Failed to upload image", e);
        }
    }
}
