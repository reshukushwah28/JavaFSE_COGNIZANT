# Exercise 1: Configuring Basic Spring Application

## Objective
Set up a basic Maven-based Spring project and configure Spring beans (`BookService` and `BookRepository`) using pure XML configuration.

---

## Folder Structure
```text
Exercise_1/
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

### 1. pom.xml
* **Purpose**: Declares project structure, Java version settings, and Spring framework imports.
* **Complete Code**: See [pom.xml](file:
* **Line-by-Line Explanation**:
  - `groupId`, `artifactId`, `version`: Maven coordinates.
  - `properties`: Forces source/target compiler compatibility to Java 8.
  - `spring-context`: Provides the core Spring container classes.
* **Common Errors**: Incorrect Maven compiler version or repository timeouts.
* **Interview Questions**: What is the purpose of pom.xml? (Manages build configs, dependencies, plugins, and coordinates).

### 2. applicationContext.xml
* **Purpose**: Traditional XML configuration specifying Spring bean definitions.
* **Complete Code**: See [applicationContext.xml](file:
* **Line-by-Line Explanation**:
  - `<beans ...>`: Root XML tag specifying the Spring schema namespace.
  - `<bean id="bookRepository".../>`: Instantiates `BookRepository`.
  - `<property name="bookRepository" ref="bookRepository" />`: Invokes `setBookRepository` on the service bean.
* **Common Errors**: Typing errors in package names or property names (raises `BeanCreationException`).
* **Interview Questions**: What occurs during context loading? (Spring reads XML, instantiates beans via reflection, and links properties).

### 3. BookRepository.java
* **Purpose**: Exposes data layer connectivity methods.
* **Complete Code**: See [BookRepository.java](file:
* **Line-by-Line Explanation**:
  - `checkRepository()`: Outputs data checks to console.
* **Interview Questions**: What are repository beans? (Components managing CRUD database communication).

### 4. BookService.java
* **Purpose**: Coordinates catalog business logic and delegates calls.
* **Complete Code**: See [BookService.java](file:
* **Line-by-Line Explanation**:
  - `setBookRepository(BookRepository)`: Receives repository dependency.
  - `manageBooks()`: Calls repository methods if injected.
* **Interview Questions**: Why decouple services from repositories? (To support easier unit testing and swap storage implementations).

### 5. LibraryManagementApplication.java
* **Purpose**: Bootstrap main class loading XML config.
* **Complete Code**: See [LibraryManagementApplication.java](file:
* **Line-by-Line Explanation**:
  - `new ClassPathXmlApplicationContext("applicationContext.xml")`: Reads resources folder XML and loads container.
  - `context.getBean("bookService")`: Retrieves the service instance.
* **Interview Questions**: What is ApplicationContext? (An interface extending BeanFactory, managing full lifecycles, configuration metadata, and AOP services).

---

## How to Run
Navigate to `LibraryManagement/Exercise_1/` in terminal and run:
```bash
mvn clean compile exec:java -Dexec.mainClass="com.library.LibraryManagementApplication"
```

---

## Expected Output
```text
BookService: Managing library catalog...
BookRepository: Checking library database connection...
```

---

## Concepts Used
* **IoC Container**: Manages bean configurations.
* **Bean Configuration**: Declaring dependencies without annotations.
* **Dependency Wiring**: Handled via XML setters.

---

## Conclusion
XML configuration is a declarative approach to managing beans and wiring in Spring applications.

