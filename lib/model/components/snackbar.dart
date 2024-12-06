import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String message,
  String title = '',
  SnackPosition position = SnackPosition.TOP,
  Color backgroundColor = Colors.black,
  int durationInSeconds = 5,
}) {
  Get.snackbar(
    title, // Title of the Snackbar
    message, // Message of the Snackbar
    snackPosition: position,
    backgroundColor: Colors.black,
    colorText: Colors.white, // Text color for the message
    duration: Duration(seconds: durationInSeconds),
    titleText: title.isNotEmpty
        ? Text(
            title,
            style: const TextStyle(
              color: Colors.white, // Hint color for the title
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w800,
              fontSize: 16, // Font size for the title
            ),
          )
        : null,
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white, // Hint color for the message
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w100,
        fontSize: 16, // Font size for the message
      ),
    ),
  );
}
