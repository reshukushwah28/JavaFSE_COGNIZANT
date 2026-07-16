# Exercise 6: Annotation Configuration

## Objective
Implement annotation-based configuration in Spring by removing manual XML bean definitions and using component scanning stereotyping annotations.

---

## Folder Structure
```text
Exercise_6/
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

### 1. BookRepository.java
* **Purpose**: Declares a data access class using `@Repository`.
* **Complete Code**: See [BookRepository.java](file:
* **Line-by-Line Explanation**:
  - `@Repository`: Stereotype annotation marking the class as a data persistence bean.
* **Interview Questions**: What is a stereotype annotation? (Special annotations like `@Repository`, `@Service`, and `@Controller` that extend `@Component`, giving specialized roles to beans).

### 2. BookService.java
* **Purpose**: Declares service processing using `@Service` and `@Autowired`.
* **Complete Code**: See [BookService.java](file:
* **Line-by-Line Explanation**:
  - `@Service`: Marks the class as a business service bean.
  - `@Autowired`: Tells Spring to automatically find a matching bean (`BookRepository`) and inject it.

### 3. applicationContext.xml
* **Purpose**: Activates component scanning.
* **Complete Code**: See [applicationContext.xml](file:
* **Line-by-Line Explanation**:
  - `<context:component-scan base-package="com.library" />`: Scans packages to register annotated classes, eliminating manually declared `<bean>` tags.

---

## How to Run
Navigate to `LibraryManagement/Exercise_6/` in terminal and run:
```bash
mvn clean compile exec:java -Dexec.mainClass="com.library.LibraryManagementApplication"
```

---

## Expected Output
```text
Initializing context with Component Scanning...
BookService: @Autowired setter method executed. BookRepository dependency injected.
Retrieving autowired BookService...
BookService: Managing library catalog...
BookRepository: Checking library database connection... (Scan Successful)
```

---

## Concepts Used
1. **Annotation-based Configuration**: Replacing XML configurations with code metadata.
2. **Component Scanning**: Automating bean identification and container registration.
3. **Stereotype Annotations**: Providing semantic classification to objects.

---

## Conclusion
Annotation-based configuration simplifies application structure by keeping wiring logic close to the implementation code.

