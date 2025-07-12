import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizopia/models/quiz_model.dart';
import 'package:quizopia/providers/quiz_provider.dart';
import 'package:quizopia/providers/user_provider.dart';
import 'package:quizopia/views/screens/question_screen.dart';
import 'package:quizopia/views/widgets/uihelper.dart';
import 'package:quizopia/services/quiz_of_week_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuizOfWeekService _quizOfWeekService = QuizOfWeekService();
  late Future<QuizModel?> _quizOfWeekFuture;

  @override
  void initState() {
    super.initState();
    _quizOfWeekFuture = _quizOfWeekService.fetchQuizOfTheWeek();
  }

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

              FutureBuilder<QuizModel?>(
                future: _quizOfWeekFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error loading Quiz of the Week: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    final quizOfWeek = snapshot.data!;
                    return Container(
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
                                  quizOfWeek.title, // Now directly accessible
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  quizOfWeek.description, // Now directly accessible
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () => navigateToQuiz(context, quizOfWeek),
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
                          // Consider using quizOfWeek.imageUrl here if you want a dynamic image
                          Image.asset(
                            "assets/images/bulb.png", // Or use NetworkImage(quizOfWeek.imageUrl)
                            height: 100,
                            width: 100,
                            errorBuilder: (_, __, ___) => const Icon(Icons.image),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('No Quiz of the Week available.');
                  }
                },
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
                    "assets/images/${quiz.id}.png", // Still using quizProvider quizzes for categories
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