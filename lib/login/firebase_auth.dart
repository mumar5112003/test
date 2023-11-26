import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> userLogin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('User login successful');
    } catch (e) {
      print('Error during user login: $e');
      // Handle login error
      rethrow; // Rethrow the exception for the UI to handle
    }
  }

  Future<void> userSignup(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signup successful');
    } catch (e) {
      print('Error during user signup: $e');
      // Handle signup error
      rethrow; // Rethrow the exception for the UI to handle
    }
  }
}
