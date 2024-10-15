import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/model/components/snackbar.dart';

class ProfileController extends GetxController {
  var selectedGender = ''.obs;
  var name = ''.obs;
  var alternateNumber = ''.obs;
  var house = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var postalcode = ''.obs;
  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setName(String value) {
    name.value = value;
  }

  void setAlternateNumber(String value) {
    alternateNumber.value = value;
  }

  void sethousename(String value) {
    house.value = value;
  }

  void setcity(String value) {
    city.value = value;
  }

  void setstate(String value) {
    state.value = value;
  }

  void setpostalcode(String value) {
    postalcode.value = value;
  }

  bool validateAddress() {
    if (house.value.isEmpty ||
        city.value.isEmpty ||
        state.value.isEmpty ||
        postalcode.value.isEmpty) {
      // Show custom Snackbar
      showCustomSnackbar(
          message: "Please fill in all address fields",
          title: "Incomplete Address");
      return false; // Validation failed
    }
    return true; // Validation passed
  }

  // Method to merge the address fields into a single string
  String getFullAddress() {
    return [
      if (house.value.isNotEmpty) house.value,
      if (city.value.isNotEmpty) city.value,
      if (state.value.isNotEmpty) state.value,
      if (postalcode.value.isNotEmpty) "- ${postalcode.value}",
    ].join(', ').trim();
  }

  bool validateDetails() {
    if (name.value.isEmpty || selectedGender.value.isEmpty) {
      // Show custom Snackbar
      showCustomSnackbar(
          message: "Please fill in all Details fields",
          title: "Incomplete Details");
      return false; // Validation failed
    }
    return true; // Validation passed
  }

  String getFullDetails() {
    return [
      if (name.value.isNotEmpty) name.value,
      if (selectedGender.value.isNotEmpty) selectedGender.value,
      (alternateNumber.value)
    ].join(', ').trim();
  }

  Future<void> sendProfileData() async {
    // Validate details and address before sending
    if (validateDetails() && validateAddress()) {
      print("valid");
      // Create full address
      String fullAddress = getFullAddress();

      // Call the ApiService to send details
      ApiService apiService = ApiService();
      await apiService.sendDetails(
        name.value,
        selectedGender.value,
        alternateNumber.value,
        fullAddress,
      );
    } else {
      print("not valid");
    }
  }
}
