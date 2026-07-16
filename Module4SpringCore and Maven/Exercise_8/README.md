# Exercise 8: Basic Spring AOP

## Objective
Implement a basic Aspect-Oriented Programming (AOP) logging aspect utilizing only `@Before` and `@After` advices inside a Spring application.

---

## Folder Structure
```text
Exercise_8/
â”œâ”€â”€ src/
â”‚   â”œâ”€â”€ main/
â”‚   â”‚   â”œâ”€â”€ java/
â”‚   â”‚   â”‚   â””â”€â”€ com/library/
â”‚   â”‚   â”‚       â”œâ”€â”€ aspect/
â”‚   â”‚   â”‚       â”‚      LoggingAspect.java
â”‚   â”‚   â”‚       â”œâ”€â”€ repository/
â”‚   â”‚   â”‚       â”‚      BookRepository.java
â”‚   â”‚   â”‚       â”œâ”€â”€ service/
â”‚   â”‚   â”‚       â”‚      BookService.java
â”‚   â”‚   â”‚       â””â”€â”€ LibraryManagementApplication.java
â”‚   â”‚   â””â”€â”€ resources/
â”‚   â”‚          applicationContext.xml
â””â”€â”€ pom.xml
```

---

## Files Used

### 1. LoggingAspect.java
* **Purpose**: Declares basic advices firing before and after target methods.
* **Complete Code**: See [LoggingAspect.java](file:
* **Line-by-Line Explanation**:
  - `@Before("execution(* com.library.service.BookService.*(..))")`: Executes prior to any method in the service class.
  - `@After("execution(* com.library.service.BookService.*(..))")`: Executes post method execution (irrespective of successful completion or exceptions).

### 2. applicationContext.xml
* **Purpose**: Configures XML bean declarations and AOP proxy mappings.
* **Complete Code**: See [applicationContext.xml](file:

---

## How to Run
Navigate to `LibraryManagement/Exercise_8/` in terminal and run:
```bash
mvn clean compile exec:java -Dexec.mainClass="com.library.LibraryManagementApplication"
```

---

## Expected Output
```text
Initializing XML AOP context...
Executing manageBooks()...
[AOP BEFORE] Executing method: manageBooks
BookService: Managing library catalog...
BookRepository: Checking library database connection...
[AOP AFTER] Finished method: manageBooks
```

---

## Concepts Used
* **Before Advice**: Runs prior to join point execution. Usually used to check credentials, arguments, or setup pre-conditions.
* **After (Finally) Advice**: Runs after join point completes (whether normally or throwing an exception). Typically used to release system resources, close database links, or cleanup environments.
* **AspectJ Auto Proxy**: Instantiates the AOP proxy weaver in the container.

---

## Conclusion
Setting up AOP advices allows encapsulating repetitive cross-cutting tasks into simple aspect classes, resulting in clean, readable business logic.

