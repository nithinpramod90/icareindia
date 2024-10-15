import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/vie-model/location_fetch_controller.dart';
import 'package:icareindia/views/presentation/search_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomePage;

  const CustomAppBar({super.key, required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    // Use Get.put if the controller is not already registered
    final locationController = Get.put(LocationFetchController());

    locationController.loadSavedLocationAndCategories();

    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/locationicon.png'),
      ),
      title: Obx(() => Text(
            locationController.address.value,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.normal,
              fontSize: 24,
            ),
          )),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Get.to(() => SearchScreen());

            _performSearch(isHomePage);
          },
        ),
      ],
      backgroundColor: Colors.grey.shade300,
      elevation: 0,
    );
  }

  void _performSearch(bool isHomePage) {
    if (isHomePage) {
      print("Searching on Home Page");
    } else {
      print("Searching on Other Page");
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
