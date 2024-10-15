import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/model/components/loader.dart';
import 'package:icareindia/model/components/snackbar.dart';
import 'package:icareindia/vie-model/category_controller.dart';
import 'package:icareindia/views/presentation/home_screen.dart';

class LocationFetchController extends GetxController {
  final ApiService apiService = ApiService();
  final CategoryController categoryController = Get.put(CategoryController());

  // Initialize GetStorage
  final storage = GetStorage();

  var name = ''.obs;
  var address = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedLocationAndCategories(); // Load data from storage on init
  }

  // Load saved name, address, and categories from GetStorage
  void loadSavedLocationAndCategories() {
    name.value = storage.read('name') ?? 'Guest';
    address.value = storage.read('address') ?? 'No address saved';

    final savedCategories = storage.read<List<dynamic>>('categories');
    if (savedCategories != null) {
      categoryController.categories.value =
          savedCategories.cast<Map<String, dynamic>>();
      print("Loaded categories from storage.");
    }
  }

  Future<void> fetchLocation() async {
    Get.dialog(
      const LottieLoader(),
      barrierDismissible: false,
    );

    try {
      isLoading.value = true;
      final locationData = await apiService.fetchLocation();

      if (locationData['success']) {
        print("Data fetched successfully.");
        name.value = locationData['name'];
        final latitude = locationData['latitude'];
        final longitude = locationData['longitude'];

        // Fetch the address using reverse geocoding
        await fetchAddressFromCoordinates(latitude, longitude);

        // Fetch categories from API and save them
        await categoryController.fetchCategories();
        storage.write('categories', categoryController.categories);

        // Save name and address to GetStorage
        storage.write('name', name.value);
        storage.write('address', address.value);
        Get.back(); // Close the loader

        // Prepare the arguments map
        final arguments = {
          'categories': categoryController.categories,
          'name': name.value,
          'address': address.value,
        };

        // Navigate to HomeScreen and pass the arguments
        Get.off(() => HomeScreen(), arguments: arguments);
      } else {
        Get.back();
        showCustomSnackbar(
          message: locationData['message'],
          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.back();
      print('Error: $e');
      showCustomSnackbar(
        message: "An unexpected error occurred. Please try again.",
        title: 'Error',
        position: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Reverse geocode to get the address from latitude and longitude
  Future<void> fetchAddressFromCoordinates(
      String latitude, String longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(latitude),
        double.parse(longitude),
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value = '${place.street}, ${place.locality}, ${place.country}';
        print("Address: ${address.value}");
      } else {
        address.value = 'No address found';
      }
    } catch (e) {
      print('Error fetching address: $e');
      address.value = 'Error fetching address';
    }
  }
}
