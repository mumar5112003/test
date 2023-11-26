import 'package:flutter/material.dart';
import 'package:test/admin/admin_panel.dart';
import 'package:test/login/signup.dart';
import 'package:test/user/user_screen.dart';
import 'firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isUserSelected = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isUserSelected) {
                          // Clear text fields when toggling
                          emailController.clear();
                          passwordController.clear();
                        }
                        isUserSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isUserSelected ? Colors.blue : Colors.grey,
                    ),
                    child: const Text('User'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (!isUserSelected) {
                          // Clear text fields when toggling
                          emailController.clear();
                          passwordController.clear();
                        }
                        isUserSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isUserSelected ? Colors.grey : Colors.blue,
                    ),
                    child: const Text('Admin'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
              onPressed: isLoading ? null : _handleLogin,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            const SizedBox(height: 20),
            if (isUserSelected)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    _userLogin();
  }

  void _userLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      await AuthService()
          .userLogin(
            emailController.text,
            passwordController.text,
          )
          .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => !isUserSelected
                      ? const AdminPanel()
                      : const UserScreen())));
      // Handle successful login
    } catch (e) {
      // Handle login error
      print('Error during user login: $e');
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
