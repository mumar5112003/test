import 'package:flutter/material.dart';
import 'firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'email',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _handleSighup,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Signup'),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSighup() {
    _userSignup();
  }

  void _userSignup() async {
    setState(() {
      isLoading = true;
    });

    try {
      await AuthService()
          .userSignup(
            emailController.text,
            passwordController.text,
          )
          .then((value) => Navigator.pop(context));
      // Handle successful signup
    } catch (e) {
      // Handle signup error
      print('Error during user signup: $e');
      _showErrorSnackbar("Error during login: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
