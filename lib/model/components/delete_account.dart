import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';

void showDeleteAccountDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text(
        "Delete Account",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Urbanist',
        ),
      ),
      content: const Text(
        "Are you sure you want to delete your account? This action cannot be undone.",
        style: TextStyle(fontFamily: 'Urbanist'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist',
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // Call delete account function here
            deleteAccount();
          },
          child: const Text(
            "Delete",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist',
            ),
          ),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

void deleteAccount() {
  final ApiService apiService = ApiService();
  apiService.delete();
  // Perform your delete account logic here, such as calling an API or deleting session data
  // For example:
  print("Account deleted");
  Get.back(); // Close the dialog after deletion
}
