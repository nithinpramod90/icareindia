import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/vie-model/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenViewModel>(
      init: SplashScreenViewModel(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFD9D9D9),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
