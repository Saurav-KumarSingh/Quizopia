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

  static Widget categoryCard(String title, String assetPath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 60),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}