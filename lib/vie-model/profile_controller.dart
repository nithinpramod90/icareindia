import 'package:get/get.dart';

class ProfileController extends GetxController {
  var selectedGender = ''.obs;
  var name = ''.obs;
  var alternateNumber = ''.obs;

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setName(String value) {
    name.value = value;
  }

  void setAlternateNumber(String value) {
    alternateNumber.value = value;
  }
}
