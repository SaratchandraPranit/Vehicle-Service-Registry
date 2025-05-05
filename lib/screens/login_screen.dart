import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../utils/app_icons.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email and password cannot be empty")),
      );
      return;
    }

    try {
      var user = await AuthService().login(
        emailController.text,
        passwordController.text,
      );
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid email or password")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF242526), // Facebook-style dark background
      appBar: AppBar(
        title: Text("Login", style: TextStyle(fontFamily: 'Roboto')),
        backgroundColor: Color(0xFF1877F2), // Facebook Blue
        leading: IconButton(
          icon: AppIcons.back(color: Colors.white, size: 24.0),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(emailController, "Email"),
            _buildTextField(passwordController, "Password", isPassword: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1877F2), // Facebook Blue
                foregroundColor: Colors.white, // White text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/signup"),
              child: Text(
                "Create Account",
                style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black54, // Improved contrast for text fields
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        obscureText: isPassword,
        style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
      ),
    );
  }
}
