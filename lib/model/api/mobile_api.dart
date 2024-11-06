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
import 'package:icareindia/views/presentation/slots_screen.dart';
import 'package:icareindia/views/presentation/sucess_screen.dart';
import 'package:icareindia/views/presentation/welcome_screen.dart';

class ApiService {
  //storing of sessionid
  final storage = const FlutterSecureStorage();

//get session id
  Future<String?> getSessionId() async {
    return await storage.read(key: 'sessionId');
  }

  Future<void> deleteSessionId() async {
    await storage.delete(key: 'sessionId');
    print('Session ID deleted');
  }

  Future<void> deleteRefreshToken() async {
    await storage.delete(key: 'Refreshtoken');
    print('Refresh ID deleted');
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'Refreshtoken');
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
        print("$success,$message,$exists");

        if (exists) {
          final String sessionid = responseData["sessionid"];
          final String refreshtoken = responseData["refresh_token"];
          await storage.write(key: 'Refreshtoken', value: refreshtoken);
          await storage.write(key: 'sessionId', value: sessionid);
          await locationFetchController.fetchLocation();
        } else {
          // Navigate to registration screen if user doesn't exist (e.g., RegistrationScreen)
          Get.off(() => CreateProfileScreen());
        }
      } else {
        // If success is false, show error in a snackbar
        showCustomSnackbar(
          message: message, // Show thpe message from the response
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

  Future<void> refreshtoken() async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/token/refresh');
    final refreshtoken = await getRefreshToken();
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'refresh': refreshtoken,
        }),
      );

      // Parse the response body as JSON
      final responseData = jsonDecode(response.body);

      final String sessionid = responseData["access"];

      print("$refreshtoken,$sessionid");
      if (response.statusCode == 200) {
        await storage.write(key: 'sessionId', value: sessionid);
      } else {
        // If success is false, show error in a snackbar
        showCustomSnackbar(
          message:
              "Server Under Service", // Show thpe message from the response
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
      final String refreshtoken = responseData['refresh_token'];
      print("$success,$message,$sessionid,$refreshtoken");
      if (success) {
        print("sucess");
        await storage.write(key: 'sessionId', value: sessionid);
        await storage.write(key: 'Refreshtoken', value: refreshtoken);

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
      // Get.off(() => const SuccessScreen(
      //       message: 'Sucessfull Luttapi',
      //     ));

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
          'Authorization': 'Bearer $sessionId',
        },
        body: jsonEncode({
          'lat': lat,
          'lon': lon,
        }),
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
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
          'Authorization': 'Bearer $sessionId',
        },
        body: jsonEncode({
          'sessionId': sessionId,
        }),
      );
      final responseData = jsonDecode(response.body);
      print(responseData);

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
        print(responseData);
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

  Future<Map<String, dynamic>> sendissue(String id) async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/issuedetails');

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
      final bool success = responseData['success'] ?? false;

      if (success) {
        final maincat = responseData['maincat'];
        final subcat = responseData['subcat'];
        return {
          'success': true,
          'maincat': maincat,
          'subcat': subcat,
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to fetch issue details.',
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

  Future<void> registerissue(String issue, String subcatid) async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/registerissue');
    final sessionid = await getSessionId();
    String audio = "jhhhgf";
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sessionid',
        },
        body: jsonEncode({
          'audio': audio,
          'issue': issue,
          'subcatid': subcatid,
        }),
      );
      final responseData = jsonDecode(response.body);
      final bool success = responseData['success'] ?? false;

      if (success) {
        print("success");
      } else {
        showCustomSnackbar(
          message:
              "Can't Place Service Please Try Later", // Show the message from the response
          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchslots() async {
    final url = Uri.parse('${AppConfig.baseUrl}/users/availableslots');

    // Show a loading dialog
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

        // Extracting fields from the response with fallback values
        final bool success = responseData['success'] ?? false;
        final String message = responseData['message'] ?? '';
        final List<dynamic> schedules = responseData['schedules'] ?? [];

        // Log for debugging
        print('Response Data: $responseData');
        print(schedules);

        if (success && schedules.isNotEmpty) {
          print("object");
          // Navigating to SlotsScreen with schedules as arguments
          Get.off(
            () => const SlotsScreen(),
            arguments: {
              'schedules': schedules,
            },
          );
        } else {
          print('No schedules available');
        }

        return {
          'success': success,
          'message': message,
          'schedules': schedules,
        };
      } else {
        throw Exception('Failed to load slots');
      }
    } catch (e) {
      print('Error fetching slots: $e');
      throw Exception('Error fetching slots: $e');
    } finally {
      Get.back(); // Close the loading dialog
    }
  }

  Future<void> sendschedule(String date, String time) async {
    final sessionId = await getSessionId();
    final url = Uri.parse('${AppConfig.baseUrl}/users/addtimeslot');
    Get.dialog(
      const LottieLoader(),
      barrierDismissible: false,
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sessionId',
        },
        body: jsonEncode({
          'date': date,
          'time': time,
        }),
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      final bool success = responseData['success'];
      final String message = responseData['message'];
      print("$success,$message");
      if (success) {
        Get.back();
        Get.to(() => const SuccessScreen(
              message: "Service Placed SucessFully",
            ));
        // Navigate to registration screen if user doesn't exist (e.g., RegistrationScreen)
      } else {
        // If success is false, show error in a snackbar
        showCustomSnackbar(
          message: message, // Show the message from the response
          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        await fetchslots();
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

  Future<Map<String, dynamic>?> fetchUserData() async {
    final sessionId = await getSessionId();
    final url = Uri.parse('${AppConfig.baseUrl}/users/profile');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sessionId',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  Future<void> logout() async {
    final sessionId = await getSessionId();

    final refreshtoken = await getRefreshToken();
    final url = Uri.parse('${AppConfig.baseUrl}/users/logout');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sessionId',
        },
        body: jsonEncode({
          'refreshtoken': refreshtoken,
        }),
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      final bool success = responseData['success'];
      final String message = responseData['message'];
      print("$success,$message");
      if (success) {
        await deleteSessionId();
        await deleteRefreshToken();
        Get.back();
        Get.off(() => WelcomeScreen());
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

  Future<void> delete() async {
    final sessionId = await getSessionId();

    final refreshtoken = await getRefreshToken();
    final url = Uri.parse('${AppConfig.baseUrl}/users/delete');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sessionId',
        },
        body: jsonEncode({
          'refreshtoken': refreshtoken,
        }),
      );
      final responseData = jsonDecode(response.body);
      print(responseData);
      final bool success = responseData['success'];
      final String message = responseData['message'];
      print("$success,$message");
      if (success) {
        await deleteSessionId();
        await deleteRefreshToken();
        Get.back();
        Get.off(() => WelcomeScreen());
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

  Future<Map<String, List<Map<String, dynamic>>>?> services() async {
    final sessionId = await getSessionId();
    final url = Uri.parse('${AppConfig.baseUrl}/users/myservices');

    // Show loader
    // Get.dialog(
    //   const LottieLoader(),
    //   barrierDismissible: false,
    // );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $sessionId',
        },
      );

      final responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        return {
          'upcoming': List<Map<String, dynamic>>.from(responseData['upcoming']),
          'previous': List<Map<String, dynamic>>.from(responseData['previous']),
        };
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      print('Error: $e');

      // Show error message to the user
      showCustomSnackbar(
        message: "An unexpected error occurred. Please try again.",
        title: 'Error',
        position: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );

      return null;
    }
  }

  Future<Map<String, dynamic>?> servicesdetail(String id) async {
    final sessionId = await getSessionId();
    final url = Uri.parse('${AppConfig.baseUrl}/users/servicedetails');

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
          'Authorization': 'Bearer $sessionId',
        },
        body: jsonEncode({
          'id': id,
        }),
      );

      Get.back(); // Hide loader

      final responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        return {
          'image': responseData['image'],
          'maincat': responseData['maincat'],
          'subcat': responseData['subcat'],
          'description': responseData['description'],
          'spare': responseData['spare'],
          'service': responseData['service'],
          'total': responseData['total'],
          'upcoming': responseData['upcoming'],
        };
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      print('Error: $e');
      Get.back(); // Hide loader if error occurs

      // Show error message to the user
      showCustomSnackbar(
        message: "An unexpected error occurred. Please try again.",
        title: 'Error',
        position: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );

      return null;
    }
  }
}
