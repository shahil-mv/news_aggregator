# News Aggregator App
A professional news aggregation application that delivers top headlines seamlessly.

A production-ready Flutter application built to demonstrate enterprise-level architectural patterns, clean code principles, and modern mobile development practices. This repository serves as a showcase of scalable app development, drawing upon 5+ years of software engineering experience to deliver a maintainable, testable, and robust solution.

## 🏗 Architectural Choices

The core philosophy behind this project is **maintainability through separation of concerns**. I have explicitly chosen an architecture that scales well for large teams and complex, evolving requirements.

### 1. Clean Architecture & SOLID Principles
The application strictly enforces Robert C. Martin's Clean Architecture, dividing the project into independent, decoupled layers:
- **Domain Layer**: The innermost layer. It contains enterprise-wide business rules (Entities) and application-specific business rules (Use Cases). It has **zero dependencies** on external frameworks or UI, ensuring core logic is isolated and fully testable.
- **Data Layer**: Responsible for coordinating data from multiple sources (remote APIs, local databases). It implements the repository interfaces defined in the domain layer.
- **Presentation Layer**: Contains the UI elements (Widgets/Pages) and State Management (BLoC). It is completely decoupled from business logic and acts merely as a visualizer of state.

This rigid separation ensures that changes in the UI or external services do not ripple into the core business logic, adhering to the Single Responsibility and Dependency Inversion principles.

### 2. State Management: BLoC (Business Logic Component)
I opted for the **BLoC pattern** over alternatives like Provider or Riverpod for this specific project because of its strict unidirectional data flow and excellent traceability. BLoC forces a clear separation between events (inputs) and states (outputs), making the presentation logic highly predictable and easy to unit test. It particularly shines in complex applications where state transitions must be rigorously tracked and debugged.

### 3. Networking & Code Generation: Dio + Retrofit
For the networking stack, I combined **Dio** (for robust interception, timeout management, and HTTP control) with **Retrofit** (for type-safe HTTP clients).
- Using code generation for network mapping reduces boilerplate, minimizes human error in JSON parsing, and accelerates development securely.
- Interceptors are easily hooked in for centralized logging, token refreshment, and generic error handling.

### 4. Functional Programming & Error Handling: Dartz
To avoid the ambiguity of `null` returns and unhandled exceptions, the application utilizes **Dartz** to bring functional programming concepts to Dart.
- **Either<Failure, Success>** is used extensively across the Domain and Data layers. This forces the caller (usually the BLoC) to explicitly handle both success and failure execution paths at compile time, dramatically reducing runtime crashes and defensive coding boilerplate.

### 5. Dependency Injection: GetIt
**GetIt** operates as a service locator, registering our dependencies in a centralized, hierarchical configuration. It manages singletons and factory instances smoothly, allowing us to easily swap out concrete implementations (like an API service) for mocks during test environments without altering the consumer classes.

### 6. Value Equality: Equatable
Models, Entities, States, and Events extend **Equatable**. This bypasses Dart's default referential equality in favor of value equality, drastically optimizing widget rebuilds (BLoC only emits new states if the value changes) and simplifying test assertions.

## 🧪 Testing Strategy (TDD Approach)

Drawing from extensive experience, I approach testing not as an afterthought, but as a design tool. Test-Driven Development ensures APIs are highly usable before implementation details are cemented.
- **Unit Testing**: Comprehensive unit tests govern the Domain and Data layers.
- **Bloc Testing**: The `bloc_test` package is used to verify chronological state emissions based on specific events.
- **Mocking**: `mocktail` is utilized to stub dependencies and verify interactions, completely isolating the unit under test.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.10.4`
- Dart SDK `>=3.10.4 <4.0.0`

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd news_aggregator
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate code (for Retrofit, JSON Serializable, and Mocktail):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

5. **Run tests:**
   ```bash
   flutter test
   ```

## 💡 Key Takeaway
This project demonstrates how a senior developer approaches mobile application structure: minimizing technical debt from day one, ensuring every layer is highly testable, and building an architecture capable of accommodating shifting product requirements without tearing down the foundations.

Built with ❤️ by Mohammed Shahil