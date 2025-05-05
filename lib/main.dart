import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/service_form.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    "snOpbgwYVBvNTOA65Z98ZqdvVBqdr1RsbfQiSgGD",
    "https://parseapi.back4app.com",
    clientKey: "hoTeNK6KKjOgUo3SGB3mgrWeGKYnGZPF6lqnwlxD",
    autoSendSessionId: true,
  );
  var response = await Parse().healthCheck();
  print(response.success ? "Connected to Back4App ✅" : "Connection failed ❌");

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(0xFF1877F2), // Facebook Blue
        scaffoldBackgroundColor: Color(0xFF242526), // Dark Mode
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // White Text
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1877F2), // Facebook Blue
            foregroundColor: Colors.white, // White Text
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Default icon color
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // AppBar icon color
          ),
        ),
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/add': (context) => ServiceForm(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => ServiceForm(existingData: args),
          );
        }
        return null;
      },
    ),
  );
}
