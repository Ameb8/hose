package edu.cwu.capstone.hose.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<Bucket4jRateLimitingFilter> rateLimitFilter(
            Bucket4jRateLimitingFilter filter) {

        FilterRegistrationBean<Bucket4jRateLimitingFilter> registration =
                new FilterRegistrationBean<>();

        registration.setFilter(filter);
        registration.addUrlPatterns("/*"); // apply to all endpoints
        registration.setOrder(1); // high priority

        return registration;
    }
}
