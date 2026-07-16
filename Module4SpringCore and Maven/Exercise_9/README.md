# Exercise 9: Spring Boot CRUD Application

## Objective
Create a standalone Spring Boot 2.x application demonstrating automatic configuration, H2 database connection pools, Spring Data JPA repositories, and basic REST CRUD controller actions.

---

## Folder Structure
```text
Exercise_9/
â”œâ”€â”€ src/
â”‚   â”œâ”€â”€ main/
â”‚   â”‚   â”œâ”€â”€ java/
â”‚   â”‚   â”‚   â””â”€â”€ com/library/
â”‚   â”‚   â”‚       â”œâ”€â”€ Book.java
â”‚   â”‚   â”‚       â”œâ”€â”€ BookRepository.java
â”‚   â”‚   â”‚       â”œâ”€â”€ BookController.java
â”‚   â”‚   â”‚       â””â”€â”€ LibraryManagementApplication.java
â”‚   â”‚   â””â”€â”€ resources/
â”‚   â”‚          application.properties
â””â”€â”€ pom.xml
```

---

## Files Used

### 1. Book.java
* **Purpose**: JPA Database Entity representing the book schema.
* **Complete Code**: See [Book.java](file:
* **Line-by-Line Explanation**:
  - `@Entity`: Marks class for database mapper bindings.
  - `@Id`: Designates the primary key.
  - `@GeneratedValue(strategy = GenerationType.IDENTITY)`: Relies on H2 auto-increment sequences.

### 2. BookRepository.java
* **Purpose**: Interface extending `JpaRepository` to leverage automatic query methods.
* **Complete Code**: See [BookRepository.java](file:

### 3. BookController.java
* **Purpose**: Exposes REST endpoints directly mapping requests to JpaRepository CRUD actions.
* **Complete Code**: See [BookController.java](file:
* **Line-by-Line Explanation**:
  - `@RestController`: Configures class as a web controller returning serialized objects (JSON).
  - `@GetMapping`: Processes HTTP GET requests.
  - `@PostMapping`: Processes HTTP POST requests.
  - `@PutMapping`: Processes HTTP PUT updates.
  - `@DeleteMapping`: Processes HTTP DELETE actions.

### 4. application.properties
* **Purpose**: Declares H2 connection parameters and Hibernate options.
* **Complete Code**: See [application.properties](file:

---

## How to Run
Navigate to `LibraryManagement/Exercise_9/` in terminal and run:
```bash
mvn spring-boot:run
```
Once started:
* The H2 console will be available at [http:
* The API endpoints can be tested via cURL or Postman on `http:

---

## REST Endpoints & Sample JSON Payloads

### 1. Create a Book (POST `/api/books`)
* **Request JSON**:
  ```json
  {
    "title": "Sample Title",
    "author": "Sample Author"
  }
  ```
* **Expected Response (`201 Created`)**:
  ```json
  {
    "id": 1,
    "title": "Sample Title",
    "author": "Sample Author"
  }
  ```

### 2. Fetch All Books (GET `/api/books`)
* **Expected Response (`200 OK`)**:
  ```json
  [
    {
      "id": 1,
      "title": "Sample Title",
      "author": "Sample Author"
    }
  ]
  ```

---

## Annotations Explained
1. **`@RestController`**: Combines `@Controller` and `@ResponseBody` to mark classes as REST endpoints returning serialized data.
2. **`@RequestMapping`**: Configures base routing path mappings.
3. **`@Entity`**: Informs the Hibernate engine to map this Java bean to a matching database table.
4. **`@Id`**: Specifies the primary key of the entity.
5. **`@GeneratedValue`**: Defines how the primary key values are generated.

---

## Conclusion
Spring Boot greatly simplifies development by using autoconfigurations to set up DataSource connection pools, JPA properties, and web dispatchers automatically.

