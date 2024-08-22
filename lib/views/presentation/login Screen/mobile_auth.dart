import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/views/presentation/login%20Screen/otp_screen.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
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
                      "Enter your Phone Number",
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
                      "We will send confirmation code to your phone",
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
                      const SizedBox(height: 40),
                      const Row(
                        children: [
                          Text(
                            "Phone Number",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType
                            .phone, // Set the keyboard type to phone
                        decoration: const InputDecoration(
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(
                            color: Colors.black, // Hint color
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800,
                            fontSize: 16, // Font size for the hint
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black, // Text color
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w800,
                          fontSize: 24, // Big font for the phone number input
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Save or process the phone number
                          if (kDebugMode) {
                            print('Phone number: $value');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.off(() => const OtpScreen());
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
