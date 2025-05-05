# 🚗 Vehicle Service Tracker

A Flutter application to track vehicle service records. This cross-platform app supports mobile (iOS, Android) and web platforms, allowing users to manage vehicle maintenance effortlessly.

# ✨ Features

### 🔐 User Authentication

   Secure login and signup functionality using Back4App (Parse Server)

### 🧾 Service Record Management (CRUD)

   ➕ Create new service entries

   📖 Read/View a list of service records

   ✏️ Update existing service records

   ❌ Delete unwanted records


### 💻 Cross-Platform Support

  Works on Android, iOS, and modern web browsers

### 🌙 Dark Mode UI

   Sleek, Facebook-inspired dark theme for better usability

### 🔤 Web-Compatible Icons

   Uses text-based icons for optimal web rendering support

## Screenshots

[Add screenshots of your app here]

## Technologies Used

- **Flutter**: Cross-platform UI toolkit
- **Parse Server**: Backend as a service (BaaS) using Back4App
- **Material Design**: UI components and styling

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/vehicle_service_tracker.git
```

2. Navigate to the project directory:
```bash
cd vehicle_service_tracker
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

### Web Deployment

To run the app in a web browser:

```bash
flutter run -d chrome --web-renderer html
```

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── screens/                   # UI screens
│   ├── home_screen.dart       # Main service records list
│   ├── login_screen.dart      # User login
│   ├── signup_screen.dart     # User registration
│   ├── service_form.dart      # Add/edit service records
│   ├── service_model.dart     # Service data model
│   └── auth_service.dart      # Authentication service
└── utils/                     # Utility classes
    └── app_icons.dart         # Web-compatible icons
```

## Backend Setup

This app uses Back4App (Parse Server) as the backend. To set up your own backend:

1. Create an account on [Back4App](https://www.back4app.com/)
2. Create a new app
3. Set up the following classes:
   - User (default class)
   - ServiceRecords (with fields: vehicleName, serviceType, serviceDate, notes)
4. Update the Parse initialization in `main.dart` with your app keys


## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Back4App](https://www.back4app.com/)
- [Parse SDK for Flutter](https://pub.dev/packages/parse_server_sdk_flutter)
