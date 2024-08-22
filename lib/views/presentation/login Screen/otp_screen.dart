import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/views/presentation/location_screen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // String otp = '';

    return Scaffold(
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
                    Image.asset("assets/images/avathar.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "One More Thing ...",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "We have a 4 digit code to your Mobile Number",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          // setState(() {
                          //   otp = value;
                          // });
                        },
                      ),
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Get.off(() => const LocationScreen());
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
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
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
