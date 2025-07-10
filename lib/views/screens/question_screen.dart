import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizopia/models/question_model.dart';
import 'package:quizopia/models/quiz_model.dart';

class QuestionScreen extends StatefulWidget {
  final QuizModel quizData;

  const QuestionScreen({super.key, required this.quizData});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<QuestionModel> selectedQuestions;
  late List<int?> userAnswers;

  int currentQuestionIndex = 0;
  int? selectedOption;
  bool showNext = false;
  bool isLoading = false;
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  void _initializeQuiz() {
    final allQuestions = List<QuestionModel>.from(widget.quizData.questions);
    allQuestions.shuffle(); // ensure random order
    selectedQuestions = allQuestions.take(10).toList();
    userAnswers = List.filled(selectedQuestions.length, null);
    currentQuestionIndex = 0;
    selectedOption = null;
    showNext = false;
    isSubmitted = false;
  }

  void selectOption(int index) {
    setState(() {
      selectedOption = index;
      userAnswers[currentQuestionIndex] = index;
      showNext = true;
    });
  }

  void goToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
      selectedOption = userAnswers[currentQuestionIndex];
      showNext = selectedOption != null;
    });
  }

  Future<void> submitQuiz() async {
    if (isSubmitted || isLoading) return;

    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    int correct = 0;
    int incorrect = 0;
    int total = selectedQuestions.length;

    for (int i = 0; i < total; i++) {
      final correctIndex = selectedQuestions[i].correctAnswerIndex;
      if (userAnswers[i] == correctIndex) {
        correct++;
      } else {
        incorrect++;
      }
    }

    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        if (!snapshot.exists) return;

        final data = snapshot.data()!;
        transaction.update(userRef, {
          'correctAnswers': (data['correctAnswers'] ?? 0) + correct,
          'incorrectAnswers': (data['incorrectAnswers'] ?? 0) + incorrect,
          'totalAttempted': (data['totalAttempted'] ?? 0) + total,
          'totalScore': (data['totalScore'] ?? 0) + (correct * 10),
        });
      });

      isSubmitted = true;

      _showResultDialog(correct, incorrect);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  void _showResultDialog(int correct, int incorrect) {
    final score = correct * 10;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, color: Colors.amber, size: 80),
              const SizedBox(height: 20),
              const Text(
                "Congratulations!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Your Score", style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$score',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade600,
                      ),
                    ),
                    const TextSpan(
                      text: ' / 100',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "You did a great job!\nTry again or head home.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Color(0xFF555555), height: 1.5),
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        setState(() => _initializeQuiz());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Try Again"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext); // Close dialog
                        Navigator.pop(context);       // Exit quiz screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("Home"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = selectedQuestions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1E0E62),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Question ${currentQuestionIndex + 1} of ${selectedQuestions.length}",
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              Text(
                currentQ.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              Column(
                children: List.generate(currentQ.options.length, (index) {
                  final isSelected = selectedOption == index;
                  return GestureDetector(
                    onTap: () => selectOption(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.deepPurple : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      width: double.infinity,
                      child: Text(
                        currentQ.options[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const Spacer(),

              if (showNext)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : currentQuestionIndex == selectedQuestions.length - 1
                        ? submitQuiz
                        : goToNextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Color(0xFF1E0E62),
                        strokeWidth: 2,
                      )
                          : Text(
                        currentQuestionIndex == selectedQuestions.length - 1
                            ? "Submit"
                            : "Next",
                        style: const TextStyle(
                          color: Color(0xFF1E0E62),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
