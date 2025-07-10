import 'package:flutter/material.dart';
import 'package:quizopia/models/quiz_model.dart';

import '../../models/question_model.dart';

class QuestionScreen extends StatefulWidget {
  final QuizModel quizData;

  const QuestionScreen({super.key, required this.quizData});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<QuestionModel> selectedQuestions;
  int currentQuestionIndex = 0;
  int? selectedOption;
  bool showNext = false;

  @override
  void initState() {
    super.initState();

    // Shuffle and pick 10 questions
    final allQuestions = List<QuestionModel>.from(widget.quizData.questions);
    allQuestions.shuffle();
    selectedQuestions = allQuestions.take(10).toList();
  }

  void selectOption(int index) {
    setState(() {
      selectedOption = index;
      showNext = true;
    });
  }

  void goToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
      selectedOption = null;
      showNext = false;
    });
  }

  void submitQuiz() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: const Text("Thank you for participating."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
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
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Options
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
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                    onPressed: currentQuestionIndex == selectedQuestions.length - 1
                        ? submitQuiz
                        : goToNextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        currentQuestionIndex == selectedQuestions.length - 1 ? "Submit" : "Next",
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
