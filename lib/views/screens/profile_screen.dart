import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> profileData = {
    "name": "Elvie Winlose",
    "username": "@Rookie123",
    "avatar": "assets/you.png",
    "rank": "#99",
    "gamesPlayed": "250",
    "points": "1,084",
    "completionRate": "82%",
    "correctAnswers": "62%",
    "incorrectAnswers": "38%",
  };

  ProfileScreen({super.key});

  Widget statBox(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FF),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1E0E62),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(profileData["avatar"]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    profileData["name"],
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    profileData["username"],
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                statBox("World rank", profileData["rank"], Icons.emoji_events, Colors.deepOrange),
                statBox("Games played", profileData["gamesPlayed"], Icons.videogame_asset, Colors.amber),
                statBox("Points total", profileData["points"], Icons.bolt, Colors.deepPurple),
                statBox("Completion rate", profileData["completionRate"], Icons.check_circle, Colors.deepPurple),
                statBox("Correct answers", profileData["correctAnswers"], Icons.verified, Colors.amber),
                statBox("Incorrect answers", profileData["incorrectAnswers"], Icons.cancel, Colors.grey),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
