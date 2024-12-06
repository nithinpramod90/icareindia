import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/model/components/snackbar.dart';
import 'package:icareindia/vie-model/button_controller.dart';
import 'package:icareindia/vie-model/location_controller.dart';
import 'package:icareindia/vie-model/location_fetch_controller.dart';

class LocationScreen extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());
  final ApiService apiService = ApiService();
  final LocationFetchController locationFetchController =
      Get.put(LocationFetchController());

  LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStateController = Get.put(ButtonStateController());

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
                    Image.asset("assets/images/location.png"),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      " I'm curious, \n where are you right now.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.normal,
                        fontSize: 26,
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
                        "Allow your Location",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "We need your Location to give you better Experience.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: buttonStateController
                                  .isButtonDisabled.value
                              ? null // Disable button when in a loading state
                              : () async {
                                  buttonStateController
                                      .disableButton(); // Disable button on tap
                                  try {
                                    // Determine the user's position
                                    await locationController
                                        .determinePosition();

                                    // Check if a valid location was retrieved
                                    if (locationController.longitude.value !=
                                            0.0 &&
                                        locationController.latitude.value !=
                                            0.0) {
                                      print(
                                          'Longitude: ${locationController.longitude.value}');
                                      print(
                                          'Latitude: ${locationController.latitude.value}');

                                      // Send location data to the API
                                      await apiService.sendLocation(
                                        locationController.latitude.value
                                            .toString(),
                                        locationController.longitude.value
                                            .toString(),
                                      );

                                      // Fetch updated location data
                                      await locationFetchController
                                          .fetchLocation();
                                    } else {
                                      // Show a custom snackbar if location retrieval fails
                                      showCustomSnackbar(
                                        message: "Could not retrieve location",
                                        title: 'Error',
                                        position: SnackPosition.TOP,
                                        backgroundColor: Colors.black,
                                      );
                                    }
                                  } catch (e) {
                                    // Handle unexpected errors
                                    showCustomSnackbar(
                                      message: "An error occurred: $e",
                                      title: 'Error',
                                      position: SnackPosition.TOP,
                                      backgroundColor: Colors.red,
                                    );
                                  } finally {
                                    // Re-enable the button after task completion
                                    buttonStateController.enableButton();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 20),
                            backgroundColor: Colors.black, // Background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            buttonStateController.isButtonDisabled.value
                                ? 'Processing...' // Change text when disabled
                                : 'Continue',
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
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
