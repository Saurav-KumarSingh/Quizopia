import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';

Future<List<QuizModel>> fetchQuizzes() async {
  final quizzesSnapshot = await FirebaseFirestore.instance.collection('quizzes').get();
  List<QuizModel> quizzes = [];

  for (var quizDoc in quizzesSnapshot.docs) {
    final quizId = quizDoc.id;
    final quizData = quizDoc.data();

    // Fetch the subcollection 'questions'
    final questionsSnapshot = await quizDoc.reference.collection('questions').get();

    List<QuestionModel> questions = questionsSnapshot.docs
        .map((doc) => QuestionModel.fromMap(doc.id, doc.data()))
        .toList();

    quizzes.add(QuizModel.fromMap(quizId, quizData, questions));
  }

  return quizzes;
}
