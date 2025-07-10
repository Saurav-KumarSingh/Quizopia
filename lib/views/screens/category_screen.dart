import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizopia/models/quiz_model.dart';
import 'package:quizopia/providers/quiz_provider.dart';
import 'package:quizopia/views/screens/question_screen.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _navigateToQuiz(BuildContext context, QuizModel quiz) {
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
    final quizzes = quizProvider.quizzes;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Categories",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E0E62),
          ),
        ),
      ),
      body: SafeArea(
        child: quizzes.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            itemCount: quizzes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final quiz = quizzes[index];

              return UiHelper.categoryCard(
                quiz.title,
                "assets/images/${quiz.id}.png",
                    () => _navigateToQuiz(context, quiz),
              );
            },
          ),
        ),
      ),
    );
  }
}
