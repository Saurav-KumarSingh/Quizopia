import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UiHelper {
  // static CustomImage({required String img, double? scale}) {
  //   return Image.asset(
  //     "assets/images/$img",
  //     scale: scale,
  //   );
  // }

  static CustomText(
      {required String text,
        required Color color,
        required FontWeight fontweight,
        String? fontfamily,
        required double fontsize}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontsize,
          fontFamily: fontfamily ?? 'regular',
          fontWeight: fontweight,
          color: color),

    );
  }
  static CustomTextField({required TextEditingController controller}){
    return Container(
      height: 37,
      width: 345,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: "Search 'ice-cream'",
            prefixIcon: Icon(Icons.search),
            suffixIcon: Icon(Icons.mic,color: Colors.black,),
            border: InputBorder.none

        ),
      ),
    );
  }

  static Widget customButton({
    required String text,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  static Widget socialButton(IconData icon, Color color) {
    return Container(
      height: 55,
      width: 55,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Center(child: FaIcon(icon, color: color)),
    );
  }

  static Widget categoryCard(String title, String assetPath, VoidCallback onTap) {
    final safeAssetPath = (assetPath.isNotEmpty) ? assetPath : 'assets/images/tech.png';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              safeAssetPath,
              height: 60,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 60, color: Colors.redAccent);
              },
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }



  static Widget custom_podiumUser(String rank, String name, String points, String imagePath, {bool isFirst = false}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade300),
            color: isFirst ? Colors.white : Colors.grey.shade100,
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 34,
              ),
              const SizedBox(height: 8),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("$points points", style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(rank, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
      ],
    );
  }

  static Widget customrankedUser(
      String rank,
      String name,
      String points, {
        bool isCurrentUser = false,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.deepPurple.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentUser ? Colors.deepPurple : Colors.grey.shade300,
          width: isCurrentUser ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            rank,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: isCurrentUser ? Colors.deepPurple : Colors.black87,
            ),
          ),
          const SizedBox(width: 14),

          // Avatar
          const CircleAvatar(
            radius: 22,
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),

          // Name
          Expanded(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isCurrentUser ? Colors.deepPurple : Colors.black87,
              ),
            ),
          ),

          // Points
          Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                "$points pts",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

}
