import 'package:flutter/material.dart';
import 'package:quizopia/views/widgets/uihelper.dart';

class HomeScreen extends StatelessWidget {
  final Color primaryPurple = Color(0xFF2D1E73);
  final Color lightPurple = Color(0xFFEAE6FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: ListView(
            children: [
              const Text(
                "Welcome back, Saurav",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              const Text(
                "Let's play!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D1E73),
                ),
              ),
              const SizedBox(height: 20),

              // Strike Card
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Color(0xFF2D1E73),
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         "3 days strike!",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //         ),
              //       ),
              //       const SizedBox(height: 5),
              //       const Text(
              //         "+10 daily points",
              //         style: TextStyle(color: Colors.white70, fontSize: 14),
              //       ),
              //       const SizedBox(height: 10),
              //       LinearProgressIndicator(
              //         value: 0.6,
              //         color: Colors.blue[200],
              //         backgroundColor: Colors.white24,
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 25),

              const Text(
                "Quiz of the week",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Quiz Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: lightPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Design tools",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          const Text("1,997 players worldwide",
                              style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Play now!",style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/images/bulb.png",
                      height: 100,
                      width: 100,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Categories Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  UiHelper.categoryCard("Music", "assets/images/music.png"),
                  UiHelper.categoryCard("Sports", "assets/images/sports.png"),
                  UiHelper.categoryCard("Technology", "assets/images/tech.png"),
                  UiHelper.categoryCard("Science", "assets/images/science.png"),
                  UiHelper.categoryCard("Science", "assets/images/bulb.png"),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}
