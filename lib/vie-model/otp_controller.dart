import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  void setOtp(String value) {
    otpController.text = value;
  }

  String getOtp() {
    return otpController.text;
  }
}
