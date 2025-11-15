# Flutter Production-Grade Boilerplate

This project serves as a comprehensive and robust template for building scalable, maintainable, and production-ready Flutter applications. It embodies modern best practices in application architecture, state management, and error handling.

---

## Core Architectural Principles

The architecture is heavily influenced by the principles of **Clean Architecture**, designed to be scalable, testable, and easy for teams to collaborate on.

### 1. Feature-First Project Structure

Instead of organizing files by type (e.g., `widgets`, `screens`), the project is structured by **feature**. All files related to a specific feature (e.g., `auth`, `message`) are located within their own dedicated folder. This makes the codebase highly modular and easy to navigate.

-   **Scalability:** Adding a new feature is as simple as adding a new folder under `lib/features/`.
-   **Maintainability:** All related files for a feature are co-located, making debugging and refactoring straightforward.
-   **Teamwork:** Developers can work on different features with a lower risk of merge conflicts.

### 2. BLoC for State Management

We use the **BLoC (Business Logic Component)** pattern to separate business logic from the UI. The UI is a direct reflection of the state, making the application predictable and easy to debug. State classes are designed to be clean, specific, and self-descriptive.

### 3. Bulletproof Error Handling with `Either`

To prevent unhandled exceptions and make error handling explicit, the application uses the `Either` type from the `fpdart` package. Repositories **never throw exceptions**; instead, they return:

-   `Left(Failure)`: When an operation fails (e.g., server error, no network).
-   `Right(SuccessData)`: When an operation succeeds.

This pattern forces the business logic layer (BLoC) to handle both success and failure cases exhaustively, making the app more robust and crash-resistant.

### 4. Dependency Injection (DI) with GetIt

A **Service Locator** pattern is implemented using `get_it`. A central DI container (`lib/core/di/injection_container.dart`) provides instances of dependencies (Repositories, BLoCs, etc.), decoupling the code and making it easy to swap implementations (e.g., for testing).

### 5. Immutable Models with Code Generation

All data models are built using `freezed` and `json_serializable`. This ensures:

-   **Immutability:** Models are immutable, preventing accidental state mutations.
-   **Boilerplate Reduction:** `copyWith`, `fromJson`, `toJson`, and equality operators are auto-generated, eliminating manual errors.

### 6. Environment-Aware Configuration with `.env`

Sensitive and environment-specific configurations (like API base URLs) are stored in `.env` files and loaded using `flutter_dotenv`. This keeps secrets out of the codebase and allows for seamless switching between `development` and `production` environments.

---

## Project Structure Overview

```
lib/
├── core/                   # Shared code for all features
│   ├── config/             # App configuration (Routes, URLs)
│   ├── di/                 # Dependency Injection setup
│   ├── error/              # Failure and Exception classes
│   ├── network/            # Networking layer (API services)
│   ├── storage/            # Secure local storage
│   └── utils/              # Core utilities (Enums, Extensions)
│
├── features/               # Individual feature modules
│   ├── auth/               # Authentication Feature
│   │   ├── data/             # Models, Repositories, Services
│   │   └── presentation/     # BLoC, View, Widgets
│   │
│   ├── message/            # Message Listing Feature
│   │   ├── data/
│   │   └── presentation/
│   │
│   └── splash/             # Splash Screen Feature
│       ├── domain/
│       └── presentation/
│
└── main.dart               # Application entry point
```

---

## Getting Started

1.  **Install Dependencies:**

    ```sh
    flutter pub get
    ```

2.  **Create Environment Files:**

    Create a `.env` file and a `.env.dev` file in the root of the project:

    -   `.env`: `API_BASE_URL=https://your-production-api.com`
    -   `.env.dev`: `API_BASE_URL=http://10.0.2.2:3000`

3.  **Run Code Generation:**

    This is required after any changes to model files (`.dart` files annotated with `@freezed`).

    ```sh
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the Application:**

    ```sh
    flutter run
    ```

This project is now a solid foundation for any future development. Feel free to build upon it!
