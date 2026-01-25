package edu.cwu.capstone.hose.destinations;

import edu.cwu.capstone.hose.destinations.dto.DestinationDTO;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/destinations")
public class DestinationController {

    private final DestinationService service;

    public DestinationController(DestinationService service) {
        this.service = service;
    }

    @GetMapping
    public List<DestinationDTO> getAllDestinations() {
        return service.getAllDestinations();
    }
}
