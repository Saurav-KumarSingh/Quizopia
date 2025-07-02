import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      "question": "How many wizards were killed in making of Uizard?",
      "options": ["None", "10", "50", "All of them"],
    },
    {
      "question": "What is the capital of France?",
      "options": ["Berlin", "London", "Paris", "Madrid"],
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Earth", "Mars", "Jupiter", "Venus"],
    },
  ];

  int currentQuestionIndex = 0;
  int? selectedOption;
  bool showNext = false;

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
    final currentQ = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1E0E62),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/question.jpg"),
            fit: BoxFit.cover, // optional: makes the image fill the container
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                const SizedBox(height: 40),
        
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Question ${currentQuestionIndex + 1} out of ${questions.length}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currentQ["question"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 42),
        
                // Options
                Column(
                  children: List.generate(currentQ["options"].length, (index) {
                    final option = currentQ["options"][index];
                    final isSelected = selectedOption == index;

                    return GestureDetector(
                      onTap: () => selectOption(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 12), // ⬅ Increased spacing here
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? Colors.deepPurple : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        width: double.infinity,
                        child: Text(
                          option,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }),
                ),


                const Spacer(),
        
                // Show Next or Submit button conditionally
                if (showNext)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: currentQuestionIndex == questions.length - 1
                          ? submitQuiz
                          : goToNextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          currentQuestionIndex == questions.length - 1 ? "Submit" : "Next",
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
      ),
    );
  }
}
