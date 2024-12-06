import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/views/presentation/location_screen.dart';
import 'package:icareindia/views/presentation/welcome_screen.dart';

final ApiService apiService = ApiService();

const FlutterSecureStorage storage = FlutterSecureStorage();
void checkSessionAndNavigate() async {
  String? sessionId =
      await storage.read(key: 'sessionId'); // Reading the session ID

  if (sessionId != null) {
    print(sessionId);
    await apiService.refreshtoken();

    Get.off(() => LocationScreen());

    Get.back();
  } else {
    // Session ID doesn't exist, navigate to PhoneAuth
    Get.off(() => WelcomeScreen());
  }
}
