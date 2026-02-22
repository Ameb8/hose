package edu.cwu.capstone.hose.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.netty.http.client.HttpClient;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;

import java.time.Duration;

@Configuration
public class WebClientConfig {

    private HttpClient defaultHttpClient() {
        return HttpClient.create()
                .responseTimeout(Duration.ofSeconds(5));
    }

    @Bean
    public WebClient osrmWalkClient() {
        return WebClient.builder()
                .baseUrl("http://osrm-walk:5000")
                .clientConnector(new ReactorClientHttpConnector(defaultHttpClient()))
                .build();
    }

    @Bean
    public WebClient osrmCarClient() {
        return WebClient.builder()
                .baseUrl("http://osrm-car:5000")
                .clientConnector(new ReactorClientHttpConnector(defaultHttpClient()))
                .build();
    }

    @Bean
    public WebClient osrmBikeClient() {
        return WebClient.builder()
                .baseUrl("http://osrm-bike:5000")
                .clientConnector(new ReactorClientHttpConnector(defaultHttpClient()))
                .build();
    }
}