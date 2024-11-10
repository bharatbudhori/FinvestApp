# FINVEST ASSIGNMENT

## Sample Video ##
https://drive.google.com/file/d/1ebUXawbqo71dRsA-3fkkqeXFLCHTbLVI/view?usp=sharing

# Credit Card Listing & Transaction Filtering Screen (Flutter)

This project is a Flutter application designed to manage and visualize credit card data. The application features a **Credit Card Listing Screen** that displays connected credit card accounts along with their balances and transactions. Additionally, an optional **Transaction Filtering Screen** allows users to filter their transactions by various attributes such as date and category.

## Key Features

- **Credit Card Listing**: Displays a list of connected credit card accounts along with their balances and associated transactions.
- **Custom Graph**: Visualizes credit card balances using a custom graph drawn with Flutter's Canvas and `CustomPainter`.
- **Transaction Filtering**: Users can filter transactions by attributes such as date and category.
- **(Pending) Pagination**: The transaction list supports pagination to load more data incrementally (This has been done, not enabled in project as there were some improvements left).

## Architecture

This project follows the **BLoC (Business Logic Component)** pattern for state management, providing a clean separation of business logic from the UI. BLoC helps in making the app modular, testable, and maintainable.

### BLoC Components
- **home_bloc.dart**: Manages the loading and rendering of credit card data and transactions.
- **transaction_bloc.dart**: Handles loading the transaction data and applying filters (e.g., by date and category).

### State Management with Equatable
The project uses the `equatable` package to ensure proper comparison of state objects, avoiding unnecessary re-renders when the state hasn’t changed.

## Custom Graph Visualization

To provide a dynamic, intuitive visualization of the credit card balances, I created a custom graph using Flutter’s Canvas and `CustomPainter`.

## Transaction Filtering Screen

The Transaction Filter Screen allows users to filter their transaction history based on parameters such as date and category. When a user applies a filter, an event is dispatched to the `transaction_bloc.dart`, which updates the state and triggers the UI to display the filtered transactions.

## Technologies Used

- **Flutter**: For building the UI and handling state management.
- **BLoC**: For managing the business logic and state of the application.
- **Equatable**: For ensuring correct state comparison in the BLoC.
- **CustomPainter**: For creating custom graphs and visualizing the credit card balances.

## Installation Guide

Follow these steps to set up and run the project on your local machine:

### Prerequisites

Before you begin, make sure you have the following installed:

- **Flutter**: You can install Flutter by following the instructions on the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- **Android Studio** or **Visual Studio Code**: These IDEs are recommended for Flutter development, though you can use any editor of your choice.

### Step 1: Clone the Repository

Clone the project to your local machine by running:

```bash
git clone https://github.com/bharatbudhori/FinvestApp
```

### Step 2: Install Dependencies

Navigate into the project directory:

```bash
cd FinvestApp
```

Install the required dependencies by running:

```bash
flutter pub get
```

### Step 3: Set Up a Device

You can run the app on an Android emulator, iOS simulator, or a physical device.

- For Android Emulator: Open Android Studio, then go to the AVD Manager and start an emulator.
- For Physical Device: Connect your device via USB, and ensure USB debugging is enabled on Android or developer mode is enabled on iOS.

### Step 4: Run the App

Now, you can run the app by executing:

```bash
flutter run
```

This command will build and launch the app on the connected device or emulator.

### Troubleshooting

Run ***Flutter Doctor***: If you encounter any issues, run flutter doctor to check for any missing dependencies.

```bash
flutter doctor
```

