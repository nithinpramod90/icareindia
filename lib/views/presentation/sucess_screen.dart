import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/views/presentation/home_screen.dart';

class SuccessScreen extends StatelessWidget {
  final String message;

  const SuccessScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lottie animation
                    Image.asset(
                      'assets/images/sucess.png', // Your Lottie file path
                      height: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Display the text passed from another screen
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black, // Hint color for the title
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                        fontSize: 24, // Font size for the title
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Continue button
            ElevatedButton(
              onPressed: () async {
                Get.offAll(() => HomeScreen());
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                backgroundColor: Colors.black, // background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
