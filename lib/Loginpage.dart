import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_detail_application/HomeScreen.dart';

class AuthProvider with ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _isObscure = true;

  bool get isObscure => _isObscure;
  String get username => _username;
  String get password => _password;

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  bool validateCredentials(BuildContext context) {
    if (_username.isEmpty || _password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username and password cannot be empty")),
      );
      return false;
    }
    if (_username == "admin" && _password == "admin@123") {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials!")),
      );
      return false;
    }
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: AppBar(
          title: const Center(
            child: Text("Login Page", style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AuthProvider>(
            builder: (context, auth, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextField(
                    hintText: "Enter your username",
                    icon: Icons.person,
                    onChanged: auth.setUsername,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    hintText: "Enter your password",
                    icon: Icons.lock,
                    onChanged: auth.setPassword,
                    obscureText: auth.isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        auth.isObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.deepPurple,
                      ),
                      onPressed: auth.toggleObscure,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (auth.validateCredentials(context)) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductListScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required Function(String) onChanged,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
