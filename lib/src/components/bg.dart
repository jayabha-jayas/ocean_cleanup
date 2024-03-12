import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        "assets/images/bg2.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
