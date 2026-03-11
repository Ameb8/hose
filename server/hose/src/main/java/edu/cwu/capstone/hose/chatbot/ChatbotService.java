package edu.cwu.capstone.hose.chatbot;

import edu.cwu.capstone.hose.chatbot.dto.ChatbotRequest;
import edu.cwu.capstone.hose.chatbot.dto.ChatbotResponse;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientException;
import org.springframework.web.server.ResponseStatusException;

@Service
public class ChatbotService {

    private final WebClient aiClient;

    public ChatbotService(@Qualifier("aiClient") WebClient aiClient) {
        this.aiClient = aiClient;
    }

    public ChatbotResponse askAi(String query) {
        try {
            return aiClient.post()
                    .uri("/ask-ai")
                    .bodyValue(new ChatbotRequest(query))
                    .retrieve()
                    .bodyToMono(ChatbotResponse.class)
                    .block();
        } catch (WebClientException e) {
            throw new ResponseStatusException(
                    HttpStatus.SERVICE_UNAVAILABLE,
                    "AI service is temporarily unavailable",
                    e
            );
        }
    }
}