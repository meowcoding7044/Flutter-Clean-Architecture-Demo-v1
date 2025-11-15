# Flutter Production-Grade Boilerplate

This project serves as a comprehensive and robust template for building scalable, maintainable, and production-ready Flutter applications. It embodies modern best practices in application architecture, state management, and error handling.

---

## Core Architectural Principles

The architecture is heavily influenced by the principles of **Clean Architecture**, designed to be scalable, testable, and easy for teams to collaborate on.

### 1. Feature-First Project Structure

Instead of organizing files by type, the project is structured by **feature**. All files related to a specific feature (e.g., `auth`, `message`) are located within their own dedicated folder. This makes the codebase highly modular and easy to navigate.

### 2. BLoC for State Management

We use the **BLoC (Business Logic Component)** pattern to separate business logic from the UI, ensuring the UI is a direct reflection of the state.

### 3. Bulletproof Error Handling with `Either`

To prevent unhandled exceptions and make error handling explicit, the application uses the `Either` type from the `fpdart` package. Repositories **never throw exceptions**; instead, they return a `Left(Failure)` on failure or a `Right(SuccessData)` on success.

### 4. Dependency Injection (DI) with GetIt

A **Service Locator** pattern is implemented using `get_it`. A central DI container (`lib/core/di/injection_container.dart`) provides instances of dependencies, decoupling the code.

### 5. Immutable Models with Code Generation

All data models are built using `freezed` and `json_serializable`, ensuring immutability and reducing boilerplate code.

### 6. Environment-Aware Configuration with `.env`

Sensitive and environment-specific configurations (like API base URLs) are stored in `.env` files and loaded using `flutter_dotenv`.

---

## Backend for Testing

This Flutter application is designed to work with a specific Nest.js backend for testing and development purposes. You can find the backend repository and setup instructions here:

-   **Repository:** [https://github.com/meowcoding7044/nest-crud-101](https://github.com/meowcoding7044/nest-crud-101)

Please ensure the backend server is running before you start the Flutter application to test the complete login and data fetching flows.

---

## Getting Started

1.  **Clone the Backend and Run it:** Follow the instructions in the backend repository.

2.  **Install Flutter Dependencies:**

    ```sh
    flutter pub get
    ```

3.  **Create Environment Files:**

    Create a `.env.dev` file in the root of the project with the correct base URL for the local backend:

    -   `.env.dev`: `API_BASE_URL=http://10.0.2.2:3000`

4.  **Run Code Generation:**

    ```sh
    dart run build_runner build --delete-conflicting-outputs
    ```

5.  **Run the Application:**

    ```sh
    flutter run
    ```

This project is now a solid foundation for any future development. Feel free to build upon it!
