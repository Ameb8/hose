package edu.cwu.capstone.hose.config;

import io.github.bucket4j.Bucket;
import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Refill;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.Duration;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class Bucket4jRateLimitingFilter extends OncePerRequestFilter {

    private final Map<String, Bucket> buckets = new ConcurrentHashMap<>();

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // Get the real client IP if behind Cloudflare tunnel
        String ip = request.getHeader("CF-Connecting-IP");
        if (ip == null) ip = request.getHeader("X-Forwarded-For");
        if (ip == null) ip = request.getRemoteAddr();

        Bucket bucket = buckets.computeIfAbsent(ip, this::newBucket);

        // DEBUG ****
        System.out.println("Rate limit filter hit for IP: " + ip);


        if(bucket.tryConsume(1)) { // Allow request
            filterChain.doFilter(request, response);
        } else { // Rate limit exceeded
            response.setStatus(429);
            response.getWriter().write("Too many requests. Slow down!");
        }
    }

    private Bucket newBucket(String ip) {
        Refill refill = Refill.greedy(5, Duration.ofMinutes(1)); // 5 requests per minute
        Bandwidth limit = Bandwidth.classic(5, refill);
        return Bucket.builder().addLimit(limit).build();
    }
}
