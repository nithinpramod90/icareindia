import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/components/appbar.dart';
import 'package:icareindia/model/components/bottom_nav_bar.dart';
import 'package:icareindia/vie-model/location_fetch_controller.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationFetchController());

    locationController.loadSavedLocationAndCategories();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(isHomePage: true),
      body: SingleChildScrollView(
        // Make the entire body scrollable
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello ${locationController.name.value}",
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Lets Grab Something",
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 3),
            const Center(
              child: Text(
                "Store will be opened shotly .",
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Wrap GridView with a Container and set a maximum height
          ],
        ),
      ), // Show grid when data is loaded
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
