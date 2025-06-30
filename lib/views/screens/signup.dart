import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[800],
      body: Center(
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.symmetric(vertical:100 ),
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ), // Inside the Expanded > Container
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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text("Your username"),
                          const SizedBox(height: 6),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'winner',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                          const SizedBox(height: 16),

                          const Text("Your password"),
                          const SizedBox(height: 6),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: '****************',
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
                    text: "Sign up",
                    onPressed: () {
                      print("Sign up button pressed");
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
