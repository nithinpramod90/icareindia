import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:icareindia/model/api/config.dart';
import 'package:icareindia/model/components/loader.dart';
import 'package:icareindia/model/components/snackbar.dart';
import 'package:icareindia/vie-model/location_fetch_controller.dart';
import 'package:icareindia/views/presentation/details_screen.dart';
import 'package:icareindia/views/presentation/location_screen.dart';
import 'dart:convert';
import 'package:icareindia/views/presentation/login%20Screen/otp_screen.dart';

class ApiService {
  //storing of sessionid
  final storage = const FlutterSecureStorage();

//get session id
  Future<String?> getSessionId() async {
    return await storage.read(key: 'sessionId');
  }

  //PhoneNumber Authentication
  Future<void> sendPhoneNumber(String phoneNumber) async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/signup');
    final box = GetStorage();
    Get.dialog(
      const LottieLoader(), // Show the loader
      barrierDismissible: false, // Prevent dismissing
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        box.write('phoneNumber', phoneNumber);
        Get.back(); // Close the loader
        Get.off(() => OtpScreen());
      } else {
        Get.back();
        showCustomSnackbar(
          message: "Error in Generating OTP Please Try again after Sometime",

          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.black, // Background color
        );
        // Error
        // print('Failed to send OTP');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.back(); // Close the loader
      print('Error: $e');
      showCustomSnackbar(
        message: "An unexpected error occurred. Please try again.",
        title: 'Error',
        position: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

//OTP Sending
  Future<void> sendOtp(String otp) async {
    final LocationFetchController locationFetchController =
        Get.put(LocationFetchController());
    final url = Uri.parse('${AppConfig.baseUrl}/users/verifyotp');
    final box = GetStorage(); // GetStorage instance
    String phoneNumber = box.read('phoneNumber');
    // Show loader
    Get.dialog(
      const LottieLoader(),
      barrierDismissible: false,
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'otp': otp,
        }),
      );

      // Close loader
      Get.back();

      // Parse the response body as JSON
      final responseData = jsonDecode(response.body);

      // Extract success, message, and userExist from the response
      final bool success = responseData['success'];
      final String message = responseData['message'];
      final bool exists = responseData['exists']; // Checking userExist status
      print("$success,$message,$exists");
      if (success) {
        if (exists) {
          await locationFetchController.fetchLocation();
        } else {
          // Navigate to registration screen if user doesn't exist (e.g., RegistrationScreen)
          Get.off(() => CreateProfileScreen());
        }
      } else {
        // If success is false, show error in a snackbar
        showCustomSnackbar(
          message: message, // Show the message from the response
          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Close loader in case of an exception
      Get.back();

      // Handle any error
      print('Error: $e');
      showCustomSnackbar(
        message: "An unexpected error occurred. Please try again.",
        title: 'Error',
        position: SnackPosition.TOP,
        backgroundColor: Colors.red, // Get.dialog(
        //   const LottieLoader(),
        //   barrierDismissible: false,
        // );
      );
    }
  }

//sending Details
  Future<void> sendDetails(
      String name, gender, alternativenumber, address) async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/signup2');
    final box = GetStorage(); // GetStorage instance
    String phoneNumber = box.read('phoneNumber');
    // Show loader
    Get.dialog(
      const LottieLoader(),
      barrierDismissible: false,
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'name': name,
          'gender': gender,
          'alternativenumber': alternativenumber,
          'address': address,
        }),
      );

      // Parse the response body as JSON
      final responseData = jsonDecode(response.body);

      // Extract success, message, and userExist from the response
      final bool success = responseData['success'];
      final String message = responseData['message'];
      final String sessionid = responseData['sessionid'];
      print("$success,$message,$sessionid");
      if (success) {
        print("sucess");
        await storage.write(key: 'sessionId', value: sessionid);
        await box.remove('phoneNumber');

        Get.back();
        // Navigate to registration screen if user doesn't exist (e.g., RegistrationScreen)
        Get.off(() => LocationScreen());
      } else {
        print("not sucess");
        Get.back();
        // If success is false, show error in a snackbar
        showCustomSnackbar(
          message: message, // Show the message from the response
          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Close loader in case of an exception
      Get.back();

      // Handle any error
      print('Error: $e');
      showCustomSnackbar(
        message: "An unexpected error occurred. Please try again.",
        title: 'Error',
        position: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> sendLocation(String lat, String lon) async {
    final sessionId = await getSessionId();
    final url = Uri.parse('${AppConfig.baseUrl}/users/addlocation');
    Get.dialog(
      const LottieLoader(),
      barrierDismissible: false,
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'sessionId': sessionId,
          'lat': lat,
          'lon': lon,
        }),
      );
      final responseData = jsonDecode(response.body);
      final bool success = responseData['success'];
      final String message = responseData['message'];
      print("$success,$message");
      if (success) {
        Get.back();
        // Navigate to registration screen if user doesn't exist (e.g., RegistrationScreen)
      } else {
        // If success is false, show error in a snackbar
        showCustomSnackbar(
          message: message, // Show the message from the response
          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      // Close loader in case of an exception
      Get.back();

      // Handle any error
      print('Error: $e');
      showCustomSnackbar(
        message: "An unexpected error occurred. Please try again.",
        title: 'Error',
        position: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<Map<String, dynamic>> fetchLocation() async {
    final sessionId = await getSessionId();
    final url = Uri.parse('${AppConfig.baseUrl}/users/home');
    Get.dialog(
      const LottieLoader(),
      barrierDismissible: false,
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'sessionId': sessionId,
        }),
      );
      final responseData = jsonDecode(response.body);
      final bool success =
          responseData['success'] ?? false; // Default to false if null
      final String message = responseData['message']?.toString() ??
          'No message'; // Default to 'No message' if null
      final String name = responseData['name']?.toString() ??
          'Unknown'; // Default to 'Unknown' if null
      final String longitude = responseData['longitude']?.toString() ??
          '0.0'; // Default to '0.0' if null
      final String lattitude = responseData['lattitude']?.toString() ??
          '0.0'; // Default to '0.0' if null
      print("$success,$longitude,$lattitude,$message,$name");
      if (success) {
        print("$success,$longitude,$lattitude,$message,$name");

        Get.back();
        // Navigate to registration screen if user doesn, $name't exist (e.g., RegistrationScreen)
        return {
          'success': true,
          'latitude': responseData['lattitude'],
          'longitude': responseData['longitude'],
          'name': responseData['name'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'],
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': 'An unexpected error occurred. Please try again.',
      };
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/homecategories');

    // Show a loading dialog using GetX
    Get.dialog(
      const LottieLoader(),
      barrierDismissible: false,
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Assuming the key for your categories data is 'categories'
        final categories = List<Map<String, dynamic>>.from(responseData);

        // Return the categories list (you can manipulate data here if needed)
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    } finally {
      Get.back(); // Close the dialog
    }
  }

  Future<Map<String, dynamic>> fetchSubcategories(String id) async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/homesubcategories');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': id,
        }),
      );
      final responseData = jsonDecode(response.body);
      final bool success =
          responseData['success'] ?? false; // Default to false if null

      if (success) {
        final List<dynamic> subcategories = responseData['subcategories'] ?? [];
        final String title = responseData['title'];
        print(subcategories);
        return {
          'title': title,
          'subcategories': subcategories,
        };
      } else {
        return {
          'title': "failed",
          'subcategories': "failed to fetch categories",
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': '$e An unexpected error occurred. Please try again.',
      };
    }
  }

  Future<Map<String, dynamic>> find(String key) async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/find');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'key': key,
        }),
      );
      final responseData = jsonDecode(response.body);
      final bool success =
          responseData['success'] ?? false; // Default to false if null

      if (success) {
        final List<dynamic> result = responseData['result'] ?? [];
        print(result);
        return {
          'result': result,
        };
      } else {
        return {
          'result': "failed to fetch categories",
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        'success': false,
        'message': '$e An unexpected error occurred. Please try again.',
      };
    }
  }
}
