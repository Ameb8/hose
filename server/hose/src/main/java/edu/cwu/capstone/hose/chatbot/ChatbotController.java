package edu.cwu.capstone.hose.chatbot;

import edu.cwu.capstone.hose.chatbot.dto.ChatbotRequest;
import edu.cwu.capstone.hose.chatbot.dto.ChatbotResponse;
import edu.cwu.capstone.hose.chatbot.ChatbotService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ai")
public class ChatbotController {

    private final ChatbotService chatbotService;

    public ChatbotController(ChatbotService chatbotService) {
        this.chatbotService = chatbotService;
    }

    @PostMapping
    public ChatbotResponse askAi(@RequestBody ChatbotRequest request) {
        return chatbotService.askAi(request.getQuery());
    }
}