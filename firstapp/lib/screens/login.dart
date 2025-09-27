import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showLogin = true; // toggle between login and signup

  // Form keys & controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(showLogin ? "Login" : "Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email field
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your email" : null,
              ),

              // Password field
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "Please enter your password" : null,
              ),

              // Confirm password (only for signup)
              if (!showLogin)
                TextFormField(
                  controller: confirmPasswordController,
                  decoration:
                      const InputDecoration(labelText: "Confirm Password"),
                  obscureText: true,
                  validator: (value) {
                    if (!showLogin && value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

              const SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (showLogin) {
                      // Handle login logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Logging in...")),
                      );
                    } else {
                      // Handle signup logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Signing up...")),
                      );
                    }
                  }
                },
                child: Text(showLogin ? "Login" : "Sign Up"),
              ),

              const SizedBox(height: 10),

              // Toggle between login & signup
              TextButton(
                onPressed: () {
                  setState(() {
                    showLogin = !showLogin;
                  });
                },
                child: Text(showLogin
                    ? "Don’t have an account? Sign Up"
                    : "Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
