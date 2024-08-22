import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icareindia/model/api/config.dart';
import 'package:icareindia/model/components/snackbar.dart';
import 'package:icareindia/views/presentation/location_screen.dart';
import 'dart:convert';
import 'package:icareindia/views/presentation/login%20Screen/otp_screen.dart';

class ApiService {
  Future<void> sendPhoneNumber(String phoneNumber) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/send-otp');

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
        Get.off(() => OtpScreen());
      } else {
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
      print('Error: $e');
    }
  }

  Future<void> sendOtp(String otp) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/verify-otp');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        Get.off(() => LocationScreen());
      } else {
        showCustomSnackbar(
          message: "${response.body}",

          title: 'Error',
          position: SnackPosition.TOP,
          backgroundColor: Colors.black, // Background color
        );
        // Error
        // print('Failed to send OTP');
        print('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
