# Exercise 5: Spring IoC Container & Bean Scopes

## Objective
Demonstrate bean instantiation timing and behaviors across different scopes (Singleton and Prototype) inside the Spring IoC Container.

---

## Folder Structure
```text
Exercise_5/
â”œâ”€â”€ src/
â”‚   â”œâ”€â”€ main/
â”‚   â”‚   â”œâ”€â”€ java/
â”‚   â”‚   â”‚   â””â”€â”€ com/library/
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

### 1. applicationContext.xml
* **Purpose**: Declares bean scopes.
* **Complete Code**: See [applicationContext.xml](file:
* **Line-by-Line Explanation**:
  - `scope="singleton"`: Binds instantiation to startup. Single reference reused.
  - `scope="prototype"`: Binds instantiation to bean retrieval requests. Creates new objects every time.

### 2. LibraryManagementApplication.java
* **Purpose**: Compares references to verify container scope models.
* **Complete Code**: See [LibraryManagementApplication.java](file:
* **Line-by-Line Explanation**:
  - `context.getBean("bookRepository")` executed twice returns equal object instances.
  - `context.getBean("bookService")` executed twice calls the constructor twice and returns distinct memory objects.

---

## How to Run
Navigate to `LibraryManagement/Exercise_5/` in terminal and run:
```bash
mvn clean compile exec:java -Dexec.mainClass="com.library.LibraryManagementApplication"
```

---

## Expected Output
```text
--- STEP 1: INITIALIZING CONTAINER STARTUP ---
[IOC INSTANTIATION] BookRepository: Default Constructor Executed.
--- CONTAINER STARTUP COMPLETED ---

--- STEP 2: DEMONSTRATING SINGLETON SCOPE (BookRepository) ---
Are both BookRepository references equal? true
repo1 memory hash: 1234567
repo2 memory hash: 1234567

--- STEP 3: DEMONSTRATING PROTOTYPE SCOPE (BookService) ---
[IOC INSTANTIATION] BookService: Default Constructor Executed.
[IOC DI] BookService: setBookRepository() setter invoked.
[IOC INSTANTIATION] BookService: Default Constructor Executed.
[IOC DI] BookService: setBookRepository() setter invoked.
Are both BookService references equal? false
service1 memory hash: 8765432
service2 memory hash: 9988776
```

---

## Concepts Used
1. **IoC Container**: The core runtime environment.
2. **BeanFactory**: Core bean repository interface.
3. **ApplicationContext**: Feature-rich context subclass.
4. **Singleton Scope**: Eagerly loaded during initialization.
5. **Prototype Scope**: Lazily loaded upon retrieval.

---

## Conclusion
Understanding scopes is vital for preventing memory leaks and concurrency issues, especially when mixing stateful and stateless beans.

