import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<Map<String, dynamic>> leaderboardData = [];
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid;
    fetchLeaderboardData();
  }

  Future<void> fetchLeaderboardData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('totalScore', descending: true)
        .get();

    final List<Map<String, dynamic>> fetched = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();
      fetched.add({
        "uid": doc.id,
        "name": data["name"] ?? "Anonymous",
        "points": data["totalScore"]?.toString() ?? "0",
        "image": "assets/profile_default.png", // you can customize later
        "isCurrentUser": doc.id == currentUserId,
      });
    }

    setState(() {
      leaderboardData = fetched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Leaderboard",
          style: TextStyle(
            color: Color(0xFF1E0E62),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: leaderboardData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 24),

          // Top 3 podium
          if (leaderboardData.length >= 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                final user = leaderboardData[index];
                return UiHelper.custom_podiumUser(
                  "#${index + 1}",
                  user["name"],
                  user["points"],
                  user["image"],
                  isFirst: index == 0,
                );
              }),
            ),

          const SizedBox(height: 20),

          // Remaining users
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: leaderboardData.length - 3,
              itemBuilder: (context, index) {
                final user = leaderboardData[index + 3];
                return UiHelper.customrankedUser(
                  "#${index + 4}",
                  user["name"],
                  user["points"],
                  isCurrentUser: user["isCurrentUser"] ?? false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
