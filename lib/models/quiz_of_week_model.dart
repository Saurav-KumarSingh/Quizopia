import '../models/question_model.dart';

class QuizOfWeekModel {
  final String id;
  final String title;
  final List<QuestionModel> questions;

  QuizOfWeekModel({
    required this.id,
    required this.title,
    required this.questions,
  });

  factory QuizOfWeekModel.fromMap(String id, Map<String, dynamic> data) {
    return QuizOfWeekModel(
      id: id,
      title: data['description'] ?? '',
      questions: (data['questions'] as List<dynamic>)
          .map((q) => QuestionModel.fromMap(q['id'], q))
          .toList(),
    );
  }
}
