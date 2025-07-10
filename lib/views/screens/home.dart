import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizopia/models/quiz_model.dart';
import 'package:quizopia/providers/quiz_provider.dart';
import 'package:quizopia/providers/user_provider.dart';
import 'package:quizopia/views/screens/question_screen.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToQuiz(BuildContext context, QuizModel quiz) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionScreen(quizData: quiz),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    final quizzes = quizProvider.quizzes;
    final userName = userProvider.user?.name ?? "Player";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: ListView(
            children: [
              Text(
                "Welcome back, $userName",
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

              if (quizzes.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAE6FB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quizzes[0].title,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            const Text("1688 players worldwide", style: TextStyle(color: Colors.black54)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => navigateToQuiz(context, quizzes[0]),
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
                        errorBuilder: (_, __, ___) => const Icon(Icons.image),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 25),
              const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: quizzes.take(6).map((quiz) {
                  return UiHelper.categoryCard(
                    quiz.title,
                    "assets/images/${quiz.id}.png",
                        () => navigateToQuiz(context, quiz),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
