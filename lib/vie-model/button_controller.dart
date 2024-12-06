import 'package:get/get.dart';

class ButtonStateController extends GetxController {
  var isButtonDisabled = false.obs;

  void disableButton() {
    isButtonDisabled.value = true;
  }

  void enableButton() {
    isButtonDisabled.value = false;
  }
}
