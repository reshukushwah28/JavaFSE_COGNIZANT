package com.example.order_service;
import org.springframework.web.bind.annotation.*;
@RestController
@RequestMapping("/orders")
public class OrderController {
    @GetMapping("/{id}")
    public String getOrder(@PathVariable String id) {
        return "Order details for " + id;
    }
}
