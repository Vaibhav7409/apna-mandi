import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apna_mandi/pages/home.dart';
import 'package:apna_mandi/pages/signup.dart'; // Import the signup page
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:apna_mandi/providers/user_provider.dart';
import 'package:apna_mandi/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Initialize logger
final _logger = Logger('LoginPage');

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Add loading state
  bool _isPasswordVisible = false; // Add password visibility toggle

  @override
  void initState() {
    super.initState();
    // Check if user is already logged in
    _checkCurrentUser();
  }

  void _checkCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      _logger.info('User already logged in: ${currentUser.uid}');
      if (!mounted) return;

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUserData(
        email: currentUser.email,
        name: currentUser.email!.split('@')[0],
      );

      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/logo.png', height: 200, width: 200),
                const SizedBox(height: 10),
                Text(
                  'Welcome to Apna Mandi',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800]),
                ),
                const SizedBox(height: 30),

                // Email Input
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.green[800]),
                    hintText: 'Enter Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Input
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.green[800]),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.green[800],
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 52, 194, 59),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child:
                            const Text('Login', style: TextStyle(fontSize: 18)),
                      ),
                const SizedBox(height: 20),

                // Navigate to Signup Page
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  child: const Text('Don\'t have an account? Sign Up',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both email and password');
      return;
    }

    if (!_isValidEmail(email)) {
      _showErrorDialog('Please enter a valid email address');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _logger.info('Attempting to sign in with email: $email');

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (userCredential.user != null) {
        final user = userCredential.user!;
        _logger.info('Login successful: ${user.uid}');

        try {
          final firestoreService = FirestoreService();
          final userDoc = await firestoreService.getDocument('users', user.uid);

          if (!mounted) return;

          if (userDoc.exists) {
            final userData = userDoc.data() as Map<String, dynamic>;
            final userName = userData['name'] ?? user.email!.split('@')[0];

            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.updateUserData(
              email: user.email,
              name: userName,
              role: userData['role'],
              status: userData['status'],
            );

            _logger.info('User provider updated with Firestore data');
          } else {
            await firestoreService.addDocument('users', {
              'uid': user.uid,
              'name': user.email!.split('@')[0],
              'email': user.email,
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
              'role': 'user',
              'status': 'active',
            });

            if (!mounted) return;

            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.updateUserData(
              email: user.email,
              name: user.email!.split('@')[0],
              role: 'user',
              status: 'active',
            );

            _logger.info('New user document created in Firestore');
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );

          Future.delayed(const Duration(milliseconds: 100), () {
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          });
        } catch (e) {
          _logger.severe('Error updating user provider: $e');
          if (!mounted) return;

          Future.delayed(const Duration(milliseconds: 100), () {
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          });
        }
      } else {
        _logger.warning('Login successful but user is null');
        if (!mounted) return;
        _showErrorDialog('Login failed. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      _logger.severe('Firebase Auth Error: ${e.code} - ${e.message}');

      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password sign-in is not enabled.';
          break;
        case 'network-request-failed':
          errorMessage =
              'Network error. Please check your internet connection.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      if (!mounted) return;
      _showErrorDialog(errorMessage);
    } catch (e) {
      _logger.severe('Unexpected error during login: $e');
      if (!mounted) return;
      _showErrorDialog('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showErrorDialog(String message) {
    _logger.info('Showing error dialog: $message');
    // Use a delayed dialog to avoid navigation conflicts
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            title: const Text('Login Error'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message),
                const SizedBox(height: 10),
                const Text(
                  'Please check your credentials and try again.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _logger.info('Error dialog dismissed');
                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
      }
    });
  }
}
