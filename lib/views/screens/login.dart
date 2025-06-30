import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: const Text(
                "Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
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
                              decoration: InputDecoration(
                                hintText: 'winner@gmail.com',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 20),

                            const Text("Password"),
                            const SizedBox(height: 6),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '****************',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 34),

                            Row(
                              children: [
                                const Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "or login with",
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
                      text: "Login",
                      onPressed: () {
                        print("Login button pressed");
                      },
                    )
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
