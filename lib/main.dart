import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:quizopia/services/quiz_seeder.dart';
import 'package:quizopia/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await seedQuizData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizopia',
      home: const SplashScreen(),
    );
  }
}
