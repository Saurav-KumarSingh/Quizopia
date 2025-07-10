import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../services/quiz_service.dart';

class QuizProvider with ChangeNotifier {
  List<QuizModel> _quizzes = [];

  List<QuizModel> get quizzes => _quizzes;

  Future<void> loadAllQuizzes() async {
    _quizzes = await fetchQuizzes();
    notifyListeners();
  }

  QuizModel? getQuizByCategory(String categoryId) {
    return _quizzes.firstWhere(
          (quiz) => quiz.id == categoryId,
      orElse: () => QuizModel(
        id: '',
        title: '',
        description: '',
        imageUrl: '',
        questions: [],
      ),
    );
  }
}
