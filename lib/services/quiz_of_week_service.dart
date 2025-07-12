import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizopia/models/quiz_model.dart';
import 'package:quizopia/models/question_model.dart'; // Make sure to import QuestionModel

class QuizOfWeekService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuizModel?> fetchQuizOfTheWeek() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('quizOfTheWeek')
          .doc('current') // The fixed document ID for QOTW
          .get();

      if (doc.exists && doc.data() != null) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final String quizId = doc.id;

        // Extract and parse the questions list
        final List<dynamic> questionsData = data['questions'] ?? [];
        List<QuestionModel> parsedQuestions = questionsData.map((qData) {
          // As discussed, if questions are just maps in an array, they don't have
          // their own Firestore document ID. We can use the list index for the ID.
          final questionIndex = questionsData.indexOf(qData).toString();
          return QuestionModel.fromMap(questionIndex, qData as Map<String, dynamic>);
        }).toList();

        // Now create the QuizModel using its fromMap factory
        return QuizModel.fromMap(quizId, data, parsedQuestions);
      } else {
        print("No 'Quiz of the Week' found at 'quizOfTheWeek/current'");
        return null;
      }
    } catch (e) {
      print("Error fetching Quiz of the Week: $e");
      return null;
    }
  }
}