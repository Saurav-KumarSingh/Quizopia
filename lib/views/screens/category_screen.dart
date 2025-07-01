import 'package:flutter/material.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, String>> categories = const [
    {'title': 'Sports', 'image': 'assets/images/sports.png'},
    {'title': 'Animal', 'image': 'assets/images/animal.png'},
    {'title': 'Technology', 'image': 'assets/images/tech.png'},
    {'title': 'Science', 'image': 'assets/images/science.png'},
    {'title': 'Entertainment', 'image': 'assets/images/entertainment.png'},
    {'title': 'Music', 'image': 'assets/images/music.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Categories",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E0E62),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Grid of categories
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return UiHelper.categoryCard(category['title']!, category['image']!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
