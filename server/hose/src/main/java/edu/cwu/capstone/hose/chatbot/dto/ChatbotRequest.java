package edu.cwu.capstone.hose.chatbot.dto;

import lombok.Data;

@Data
public class ChatbotRequest {
    private String query;

    public ChatbotRequest(String query) {
        this.query = query;
    }
}