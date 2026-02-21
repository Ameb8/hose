package edu.cwu.capstone.hose.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.netty.http.client.HttpClient;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;

import java.time.Duration;

@Configuration
public class WebClientConfig {

    @Bean
    public WebClient routeWebClient() {

        HttpClient httpClient = HttpClient.create()
                .responseTimeout(Duration.ofSeconds(5));

        return WebClient.builder()
                .baseUrl("http://osrm:5000") // Walk Service
                .clientConnector(new ReactorClientHttpConnector(httpClient))
                .build();
    }
}