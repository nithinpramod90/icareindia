import 'dart:async';
import 'package:get/get.dart';
import 'package:icareindia/model/components/splash_nav.dart';
// import 'package:icareindia/views/presentation/welcome_screen.dart';

class SplashScreenViewModel extends GetxController {
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      checkSessionAndNavigate();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
