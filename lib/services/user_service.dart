import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // Fetch current logged-in user's data from Firestore
  Future<UserModel?> fetchCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromMap(doc.data()!);
  }

  // Update user's quiz performance
  Future<void> updateQuizResults({
    required int correct,
    required int incorrect,
    required int score,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userRef = _firestore.collection('users').doc(user.uid);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) return;

      final data = snapshot.data()!;
      final int currentScore = data['totalScore'] ?? 0;
      final int totalAttempted = data['totalAttempted'] ?? 0;
      final int correctAnswers = data['correctAnswers'] ?? 0;
      final int incorrectAnswers = data['incorrectAnswers'] ?? 0;

      transaction.update(userRef, {
        'totalScore': currentScore + score,
        'totalAttempted': totalAttempted + correct + incorrect,
        'correctAnswers': correctAnswers + correct,
        'incorrectAnswers': incorrectAnswers + incorrect,
      });
    });
  }

  // Optional: Log out user
  Future<void> logout() async {
    await _auth.signOut();
  }
}
