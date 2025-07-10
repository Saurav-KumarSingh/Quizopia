import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:quizopia/views/screens/bottom_nav.dart';
import 'package:quizopia/views/screens/login.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

import '../../providers/quiz_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void handleSignup() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String username = _usernameController.text.trim();

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      UiHelper.showSnackbar(context, "Please fill in all fields");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
        "name": username,
        "email": email,
        "totalScore": 0,
        "totalAttempted": 0,
        "correctAnswers": 0,
        "incorrectAnswers": 0,
        "profileImage": "",
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            // Load quiz data before navigation
            Provider.of<QuizProvider>(context, listen: false).loadAllQuizzes();
            return const BottomNavScreen();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Signup failed";
      if (e.code == 'email-already-in-use') {
        message = "Email is already in use";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      } else if (e.code == 'weak-password') {
        message = "Password should be at least 6 characters";
      }
      UiHelper.showSnackbar(context, message);
    } catch (e) {
      UiHelper.showSnackbar(context, "Something went wrong");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[800],
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 100),
              child: const Text(
                "Sign up now",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(34),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text("Email"),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'winner@gmail.com',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 16),

                            const Text("Username"),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: 'winner',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 16),

                            const Text("Password"),
                            const SizedBox(height: 6),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '********',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 34),

                            Row(
                              children: [
                                const Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "or sign up with",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                const Expanded(child: Divider(thickness: 1)),
                              ],
                            ),
                            const SizedBox(height: 30),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                UiHelper.socialButton(FontAwesomeIcons.facebookF, Colors.blue),
                                UiHelper.socialButton(FontAwesomeIcons.google, Colors.red),
                                UiHelper.socialButton(FontAwesomeIcons.xTwitter, Colors.black),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    UiHelper.customButton(
                      text: _isLoading ? "Signing Up..." : "Sign up",
                      onPressed: _isLoading ? null : handleSignup,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
