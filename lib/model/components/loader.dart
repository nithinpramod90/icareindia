import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoader extends StatelessWidget {
  const LottieLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Lottie.asset(
          'assets/images/loader.json', // Path to your Lottie file
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
