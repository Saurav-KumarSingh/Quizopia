import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future<void> seedQuizOfTheWeek() async {
  try {
    // Load JSON from assets
    String jsonData = await rootBundle.loadString('assets/quizofweek.json');
    final Map<String, dynamic> quizData = jsonDecode(jsonData);

    // Upload to Firestore under a known document id (e.g., "current")
    await FirebaseFirestore.instance
        .collection('quizOfTheWeek')
        .doc('current')
        .set(quizData);

    print("✅ Quiz of the Week seeded successfully!");
  } catch (e) {
    print("❌ Failed to seed Quiz of the Week: $e");
  }
}
