import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizopia/models/user_model.dart';
import 'package:quizopia/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizopia/views/screens/login.dart';

import 'editprofile_screen.dart';

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

  String _calculateCompletionRate(UserModel user) {
    if (user.totalAttempted == 0) return "0%";
    return "${((user.correctAnswers + user.incorrectAnswers) / user.totalAttempted * 100).round()}%";
  }

  String _calculateAccuracy(UserModel user) {
    if (user.totalAttempted == 0) return "0%";
    return "${(user.correctAnswers / user.totalAttempted * 100).round()}%";
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // Clear user from provider
    Provider.of<UserProvider>(context, listen: false).setUser(null);

    // Navigate to login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
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
                    backgroundColor: Colors.white,
                    backgroundImage: (userModel.profileImage.isNotEmpty)
                        ? NetworkImage(userModel.profileImage)
                        : null,
                    child: (userModel.profileImage.isEmpty)
                        ? const Icon(Icons.person, size: 45, color: Colors.deepPurple)
                        : null,
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
          // Stats grid
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
          SizedBox(height: 50,),

          Container(
            width: double.infinity, // make it expand to screen width
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.deepPurple),
                  label: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                  ),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero, // Removes default padding
                  ),
                ),
                const SizedBox(height: 5),
                TextButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
