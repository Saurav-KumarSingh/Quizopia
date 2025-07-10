import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizopia/providers/user_provider.dart';
import 'package:quizopia/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
    final userModel = Provider.of<UserProvider>(context).user;

    if (userModel == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FF),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1E0E62),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: userModel.profileImage.isNotEmpty
                        ? NetworkImage(userModel.profileImage)
                        : const AssetImage("assets/you.png") as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userModel.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userModel.email,
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
                statBox("Total Score", userModel.totalScore.toString(), Icons.bolt, Colors.deepPurple),
                statBox("Attempted", userModel.totalAttempted.toString(), Icons.videogame_asset, Colors.amber),
                statBox("Correct", userModel.correctAnswers.toString(), Icons.verified, Colors.green),
                statBox("Incorrect", userModel.incorrectAnswers.toString(), Icons.cancel, Colors.red),
                statBox("Completion Rate", _calculateCompletionRate(userModel), Icons.percent, Colors.teal),
                statBox("Accuracy", _calculateAccuracy(userModel), Icons.bar_chart, Colors.blueGrey),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _calculateCompletionRate(UserModel user) {
    if (user.totalAttempted == 0) return "0%";
    return "${((user.correctAnswers + user.incorrectAnswers) / user.totalAttempted * 100).round()}%";
  }

  String _calculateAccuracy(UserModel user) {
    if (user.totalAttempted == 0) return "0%";
    return "${(user.correctAnswers / user.totalAttempted * 100).round()}%";
  }
}
