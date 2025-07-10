import 'question_model.dart';

class QuizModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<QuestionModel> questions;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.questions,
  });

  factory QuizModel.fromMap(String id, Map<String, dynamic> data, List<QuestionModel> questions) {
    return QuizModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      questions: questions,
    );
  }
}
