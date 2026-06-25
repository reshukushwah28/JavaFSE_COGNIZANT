# Cognizant FSE Hands-On Practice

This repository contains solutions for the Cognizant Full Stack Engineer (FSE) Hands-on exercises. The project focuses on implementing important Object-Oriented Design Patterns using Java.

These exercises help in understanding software design principles, writing maintainable code, and preparing for Cognizant FSE training and assessments.

---

## Technologies Used

- Java
- Object-Oriented Programming (OOP)
- Design Patterns
- IntelliJ IDEA

---

## Repository Structure

```text
src/
└── Module1DesignPatterns/
    ├── Exercise-1-SingletonPattern
    ├── Exercise-2-FactoryMethodPattern
    ├── Exercise-3-BuilderPattern
    ├── Exercise-4-AdapterPattern
    ├── Exercise-5-DecoratorPattern
    ├── Exercise-6-ProxyPattern
    ├── Exercise-7-ObserverPattern
    ├── Exercise-8-StrategyPattern
    ├── Exercise-9-CommandPattern
    ├── Exercise-10-MVCPattern
    └── Exercise-11-DependencyInjection
```

---

# Design Pattern Exercises

## Exercise 1 - Singleton Pattern

### Objective
Ensure that a class has only one instance and provide a global point of access to it.

### Implementation
- Logger Class
- Private Constructor
- Static Instance
- getInstance() Method

### Real-World Use Cases
- Logging Frameworks
- Configuration Managers
- Database Connections

---

## Exercise 2 - Factory Method Pattern

### Objective
Create objects without specifying their exact classes.

### Implementation
- Document Interface
- PDF Document
- Word Document
- Excel Document
- Factory Classes

### Benefits
- Loose Coupling
- Better Maintainability
- Easy Extension

---

## Exercise 3 - Builder Pattern

### Objective
Construct complex objects step-by-step.

### Implementation
- Computer Class
- Builder Inner Class

### Benefits
- Improves Readability
- Handles Optional Parameters
- Prevents Constructor Overloading

---

## Exercise 4 - Adapter Pattern

### Objective
Allow incompatible interfaces to work together.

### Implementation
- Payment Processor Interface
- PayPal Adapter
- Stripe Adapter

### Real-World Example
Integrating third-party payment gateways into a common payment system.

---

## Exercise 5 - Decorator Pattern

### Objective
Add new functionality to objects dynamically without modifying existing code.

### Implementation
- Notifier Interface
- Email Notifier
- SMS Decorator
- Slack Decorator

### Benefits
- Open/Closed Principle
- Flexible Feature Addition

---

## Exercise 6 - Proxy Pattern

### Objective
Provide a placeholder or surrogate object to control access to another object.

### Implementation
- Image Interface
- RealImage
- ProxyImage

### Use Cases
- Lazy Loading
- Access Control
- Caching

---

## Exercise 7 - Observer Pattern

### Objective
Define a one-to-many dependency between objects so that when one object changes state, all dependents are notified.

### Implementation
- Stock Market
- Mobile App Observer
- Web App Observer

### Real-World Examples
- Notification Systems
- Event Handling
- Stock Market Applications

---

## Exercise 8 - Strategy Pattern

### Objective
Define a family of algorithms and make them interchangeable at runtime.

### Implementation
- Payment Strategy Interface
- Credit Card Payment
- PayPal Payment
- Payment Context

### Benefits
- Eliminates Large Conditional Statements
- Easy Addition of New Strategies

---

## Exercise 9 - Command Pattern

### Objective
Encapsulate requests as objects.

### Implementation
- Command Interface
- Light On Command
- Light Off Command
- Remote Control

### Benefits
- Undo/Redo Support
- Request Queuing
- Loose Coupling

---

## Exercise 10 - MVC Pattern

### Objective
Separate application logic into Model, View, and Controller components.

### Components

#### Model
- Student

#### View
- StudentView

#### Controller
- StudentController

### Benefits
- Better Code Organization
- Easier Maintenance
- Improved Scalability

---

## Exercise 11 - Dependency Injection

### Objective
Reduce dependency between classes by injecting required objects.

### Implementation
- CustomerRepository Interface
- CustomerRepositoryImpl
- CustomerService

### Benefits
- Loose Coupling
- Improved Testability
- Better Maintainability

---

# Learning Outcomes

After completing these exercises, you will understand:

- Object-Oriented Design Principles
- SOLID Principles
- Design Patterns
- Code Reusability
- Loose Coupling
- Dependency Management
- Enterprise Application Development Concepts

---

# How to Run

### Clone Repository

```bash
git clone <repository-url>
```

### Navigate to Source Folder

```bash
cd src
```

### Compile Java Files

```bash
javac *.java
```

### Run Program

```bash
java Main
```

or run individual test classes for each exercise.

---

# Key Concepts Covered

- Singleton Pattern
- Factory Method Pattern
- Builder Pattern
- Adapter Pattern
- Decorator Pattern
- Proxy Pattern
- Observer Pattern
- Strategy Pattern
- Command Pattern
- MVC Pattern
- Dependency Injection

---

# Purpose

This repository was created as part of the Cognizant Full Stack Engineer (FSE) learning journey to gain practical experience in software design patterns and enterprise application development using Java.

---

## Author

**Reshu Kushwah**

Cognizant FSE Hands-On Practice Repository
