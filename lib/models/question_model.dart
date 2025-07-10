class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuestionModel.fromMap(String id, Map<String, dynamic> data) {
    return QuestionModel(
      id: id,
      question: data['question'] ?? '',
      options: List<String>.from(data['options']),
      correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
    );
  }
}
