import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizopia/views/screens/bottom_nav.dart';
import 'package:quizopia/views/screens/signup.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

import '../../providers/quiz_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      UiHelper.showSnackbar(context, "Please enter email and password");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
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
    } catch (e) {
      UiHelper.showSnackbar(context, "Login Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[800],
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Text(
                "Welcome back",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Sign in",
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'winner@gmail.com',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("Password"),
                            const SizedBox(height: 6),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '****************',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 34),
                            // Row(
                            //   children: [
                            //     const Expanded(child: Divider(thickness: 1)),
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 10),
                            //       child: Text("or login with", style: TextStyle(color: Colors.grey[600])),
                            //     ),
                            //     const Expanded(child: Divider(thickness: 1)),
                            //   ],
                            // ),
                            // const SizedBox(height: 30),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     UiHelper.socialButton(FontAwesomeIcons.facebookF, Colors.blue),
                            //     UiHelper.socialButton(FontAwesomeIcons.google, Colors.red),
                            //     UiHelper.socialButton(FontAwesomeIcons.xTwitter, Colors.black),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    UiHelper.customButton(
                      text: "Login",
                      onPressed: login,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        "Don’t have an account? Sign up",
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
