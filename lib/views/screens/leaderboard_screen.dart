import 'package:flutter/material.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> leaderboardData = [
    {"name": "Anna D.", "points": "832", "image": "assets/anna.png", "isFirst": true},
    {"name": "Mike L.", "points": "340", "image": "assets/mike.png"},
    {"name": "Joe H.", "points": "599", "image": "assets/joe.png"},
    {"name": "Lea L.", "points": "530", "color": Colors.pink},
    {"name": "You", "points": "420", "color": Colors.green, "isCurrentUser": true},
    {"name": "Sebastian M.", "points": "410", "color": Colors.grey},
    {"name": "Garfielda C.", "points": "390", "color": Colors.purple},
  ];

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
      body: Column(
        children: [
          const SizedBox(height: 24),

          // Top 3 Users
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              final user = leaderboardData[index];
              return UiHelper.custom_podiumUser(
                "#${index + 1}",
                user["name"],
                user["points"],
                user["image"],
                isFirst: user["isFirst"] ?? false,
              );
            }),
          ),

          const SizedBox(height: 20),

          // Remaining Users
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: leaderboardData.length - 3,
              itemBuilder: (context, index) {
                final user = leaderboardData[index + 3];
                final rank = "#${index + 4}";
                return UiHelper.customrankedUser(
                  rank,
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
