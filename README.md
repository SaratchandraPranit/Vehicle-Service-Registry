# 🚗 Vehicle Service Tracker

A Flutter application to track vehicle service records. This cross-platform app supports mobile (iOS, Android) and web platforms, allowing users to manage vehicle maintenance effortlessly.

# ✨ Features

### 🔐 User Authentication

   Secure login and signup functionality using Back4App (Parse Server)
   
                                                           Login Page 
   ![loginpage](https://github.com/user-attachments/assets/ad166d49-e856-47b8-aa47-5c313b6f1b19)
   
                                                         Signup Page 
   ![Signuppage](https://github.com/user-attachments/assets/9cdb12f7-4768-4513-a85b-8ab97d54c6d6)

   

### 🧾 Service Record Management (CRUD)

                                              ➕ Create new service entries
   

 ![Add service](https://github.com/user-attachments/assets/439dc83e-22d1-4df6-bba7-c8470f281569)
 
                                            📖 Read/View a list of service records

   ![Service Records page ](https://github.com/user-attachments/assets/9c8379e1-daa1-4f6f-a638-06592f9e359a)


                                             ✏️ Update existing service records

 ![Update Record](https://github.com/user-attachments/assets/27a2032c-5134-40a6-a63f-564e197acc99)


                                              ❌ Delete unwanted records

 ![Delete record](https://github.com/user-attachments/assets/802c5641-d0b3-43b8-b4a3-6f0341a7072f)



### 💻 Cross-Platform Support

  Works on Android, iOS, and modern web browsers

### 🌙 Dark Mode UI

   Sleek, Facebook-inspired dark theme for better usability

### 🔤 Web-Compatible Icons

   Uses text-based icons for optimal web rendering support
   
### Backend - Back4App 

   ![Backend screenshot](https://github.com/user-attachments/assets/a6445d04-d318-4161-a10a-07c7e584f1c7)

   Backend Successful Connection Message from Terminal 

   ![Backend 2](https://github.com/user-attachments/assets/67d5f28c-8ddc-46df-8469-54357ea16e60)


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
git clone https://github.com/SaratChandraPranit/vehicle_service_tracker.git
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
