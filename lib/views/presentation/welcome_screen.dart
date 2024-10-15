import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:icareindia/vie-model/location_fetch_controller.dart';
import 'package:icareindia/vie-model/urls.dart';
import 'package:icareindia/views/presentation/login%20Screen/mobile_auth.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final LocationFetchController locationFetchController =
      Get.put(LocationFetchController());

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  void checkSessionAndNavigate() async {
    String? sessionId =
        await storage.read(key: 'sessionId'); // Reading the session ID

    if (sessionId != null) {
      // Session ID exists, navigate to HomeScreen
      await locationFetchController.fetchLocation();

      Get.back();
    } else {
      // Session ID doesn't exist, navigate to PhoneAuth
      Get.off(() => PhoneAuth());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 75,
                    ),
                    Image.asset("assets/images/logo.png"),
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      "Welcome to iCareIndia",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.normal,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.width / 4),
                      const Text(
                        "Empower Your Home Maintenance",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        "with Trusted Professionals",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          checkSessionAndNavigate();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 25),
                          backgroundColor: Colors.black, // background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Get Started ...",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      RichText(
                        text: TextSpan(
                          text: 'By continuing, you accept our ',
                          style: const TextStyle(
                              color: Colors.black), // Default text color
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                  color:
                                      Colors.blue), // Blue color for the link
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  privacyPolicy();
                                },
                            ),
                            const TextSpan(
                              text: '.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
