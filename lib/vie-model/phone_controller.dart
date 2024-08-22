import 'package:get/get.dart';

class PhoneController extends GetxController {
  // Observable for phone number
  var phoneNumber = ''.obs;

  // Method to update the phone number
  void setPhoneNumber(String number) {
    phoneNumber.value = number;
  }

  // Method to validate phone number (optional)
  String? validatePhoneNumber() {
    if (phoneNumber.value.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (phoneNumber.value.length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
