import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentrealm_handyman_flutter/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for email and password
  final TextEditingController _emailController = TextEditingController(text: "handyman1@gmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "password");

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Method to handle the login
  void _login(context)  {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, print the values
      String email = _emailController.text;
      String password = _passwordController.text;
      
      // Here, you can add your login logic (like API calls)
      print('Email: $email');
      print('Password: $password');

      Provider.of<AuthProvider>(context,listen: false).loginHandyMan(context, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(  // Make content scrollable
        padding: EdgeInsets.all(16.0),
        child: Form(  // Wrap the content inside a form for validation
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add some space before the logo
              SizedBox(height: 40),
              Image.asset(
                'assets/images/rentrealm_logo_cropped.png',  // Logo image
                width: 200,
                height: 150,
              ),
              SizedBox(height: 20),
              // Title text
              Text(
                'Login to Rent Realm : \n Handy Man',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // Email field with validation
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Regular expression for validating email
                  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regex = RegExp(emailPattern);
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;  // Return null if validation passes
                },
              ),
              SizedBox(height: 20),

              // Password field with validation
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;  // Return null if validation passes
                },
              ),
              SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },  // Call the _login method
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Forgot Password Link
              GestureDetector(
                onTap: () {
                  // Handle forgot password action here
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20), // Add extra space to avoid overlap

              // Option to sign up
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Don't have an account? ",
              //       style: TextStyle(fontSize: 16),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         // Navigate to Sign Up screen
              //         Navigator.pushNamed(context, '/signup');
              //       },
              //       child: Text(
              //         'Sign Up',
              //         style: TextStyle(
              //           color: Colors.blue,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 30),  // Add space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
