import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName;
  final Color primaryPurple = const Color(0xFF2D1E73);
  final Color lightPurple = const Color(0xFFEAE6FB);

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          userName = doc.data()?['name'] ?? "Player";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: ListView(
            children: [
              Text(
                "Welcome back, ${userName ?? "Loading..."}",
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              const Text(
                "Let's play!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D1E73),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Quiz of the week",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Design tools",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text("1,997 players worldwide",
                              style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Play now!", style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/images/bulb.png",
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  UiHelper.categoryCard("Music", "assets/images/music.png"),
                  UiHelper.categoryCard("Sports", "assets/images/sports.png"),
                  UiHelper.categoryCard("Technology", "assets/images/tech.png"),
                  UiHelper.categoryCard("Science", "assets/images/science.png"),
                  UiHelper.categoryCard("Science", "assets/images/bulb.png"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
