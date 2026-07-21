package com.example.payment_service;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PaymentController {
    @GetMapping("/pay")
    @CircuitBreaker(name = "paymentService", fallbackMethod = "paymentFallback")
    public String pay() {
        return "Payment processed!";
    }
    public String paymentFallback(Exception e) {
        return "Payment service is currently unavailable. Please try again later.";
    }
}
