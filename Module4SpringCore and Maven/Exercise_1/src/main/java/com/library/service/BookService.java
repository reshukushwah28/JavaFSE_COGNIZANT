package com.library.service;

import com.library.repository.BookRepository;

/**
 * Service class exposing catalog management operations.
 * Demonstrates XML Setter Injection wiring.
 */
public class BookService {

    private BookRepository bookRepository;

    
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    
    public void manageBooks() {
        System.out.println("BookService: Managing library catalog...");
        if (bookRepository != null) {
            bookRepository.checkRepository();
        } else {
            System.out.println("BookRepository dependency has not been injected!");
        }
    }
}

