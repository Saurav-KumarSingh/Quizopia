import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedQuizData() async {
  // Load JSON from assets
  String jsonString = await rootBundle.loadString('assets/quizopia_seed_data.json');
  Map<String, dynamic> data = jsonDecode(jsonString);

  for (var category in data.keys) {
    List questions = data[category];

    // Add quiz document
    final quizRef = FirebaseFirestore.instance.collection('quizzes').doc(category.toLowerCase());

    await quizRef.set({
      'title': category,
      'description': 'Test your knowledge of $category',
      'imageUrl': '',
    });

    // Add each question in the subcollection
    for (var question in questions) {
      await quizRef.collection('questions').add({
        'question': question['question'],
        'options': List<String>.from(question['options']),
        'correctAnswerIndex': question['correctAnswerIndex'],
      });
    }

    print('✅ Seeded $category with ${questions.length} questions');
  }
}
