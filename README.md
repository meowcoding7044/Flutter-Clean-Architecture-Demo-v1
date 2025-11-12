# Flutter Production-Ready Architecture Demo

This project serves as a robust template for building scalable and maintainable Flutter applications, suitable for production environments. It demonstrates a clean architecture approach by separating concerns into distinct layers and features.

## Core Architectural Principles

The architecture is heavily influenced by the principles of Clean Architecture and is designed to be scalable, testable, and easy for teams to collaborate on.

### 1. Feature-First Project Structure

Instead of organizing files by type, the project is structured by feature. This makes the codebase highly modular and easy to navigate.

- **Scalability:** Adding a new feature is as simple as adding a new folder under `lib/features/`.
- **Maintainability:** All related files for a feature are co-located, making debugging and refactoring straightforward.
- **Teamwork:** Developers can work on different features with a lower risk of merge conflicts.

### 2. BLoC for State Management

We use the **BLoC (Business Logic Component)** pattern to separate business logic from the UI, ensuring the UI is a direct reflection of the state.

- **Testability:** Business logic can be unit-tested independently of the UI.
- **Separation of Concerns:** The UI's responsibility is to render states and dispatch events.

### 3. Dependency Injection (DI) with GetIt

A **Service Locator** pattern is implemented using `get_it`. A central DI container (`lib/core/di/injection_container.dart`) provides instances of dependencies (Repositories, BLoCs, etc.) wherever needed.

- **Decoupling:** Widgets and BLoCs don't create their own dependencies; they ask for them. This makes it easy to swap implementations.
- **Centralized Management:** All dependencies are managed in one place.

### 4. Immutable Models with Code Generation

To ensure data integrity and reduce boilerplate, all data models in this project are built using the `freezed` and `json_serializable` packages.

- **Immutability:** Models are immutable by default, which prevents accidental state mutations and leads to a more predictable application state.
- **Boilerplate Reduction:** `copyWith`, `fromJson`, `toJson`, `==` operators, and `hashCode` are all generated automatically, eliminating manual errors and saving time.
- **Type Safety:** JSON serialization and deserialization are type-safe and robust.

## Project Structure Overview

```
lib/
├── core/                   # Shared code for all features
│   ├── config/             # App configuration (Routes, URLs)
│   ├── di/                 # Dependency Injection setup
│   ├── network/            # Networking layer (Not yet implemented)
│   ├── storage/            # Secure local storage
│   ├── utils/              # Core utilities (Enums, Extensions)
│   └── widgets/            # Shared widgets
│
├── features/               # Individual feature modules
│   ├── auth/               # Authentication Feature
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── message/            # Message Listing Feature
│   │   ├── data/
│   │   └── presentation/
│   │
│   └── splash/             # Splash Screen Feature
│       ├── data/
│       └── presentation/
│
└── main.dart               # Application entry point
```

## Key Features Implemented

- **Splash Screen:** Checks user login status and navigates accordingly.
- **Authentication:** A complete login flow with validation and a loading indicator.
- **Message Feed:** Fetches a list of messages and displays them.
- **Pull-to-Refresh:** Users can refresh the message feed.
- **Logout:** Securely logs the user out and clears the session.

## Core Dependencies

- `flutter_bloc`: For state management.
- `get_it`: For dependency injection.
- `http`: For making network requests.
- `flutter_secure_storage`: For securely storing user tokens.
- `freezed_annotation`: For data model generation.
- `json_annotation`: For JSON serialization.
- `intl`: For date formatting.
- `equatable`: To compare objects.

**Dev Dependencies:**
- `build_runner`: The core tool for code generation.
- `freezed`: The generator for Freezed models.
- `json_serializable`: The generator for JSON serialization.

## Getting Started

1.  **Install Dependencies:**
    ```sh
    flutter pub get
    ```

2.  **Run Code Generation:** (Required after any changes to model files)
    ```sh
    dart run build_runner build --delete-conflicting-outputs
    ```

3.  **Run the Application:**
    ```sh
    flutter run
    ```
(backend use https://github.com/meowcoding7044/nest-crud-101.git)

This project is now a solid foundation for any future development. Feel free to build upon it!
