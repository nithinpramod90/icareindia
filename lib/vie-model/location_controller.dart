import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icareindia/model/components/loader.dart';

class LocationController extends GetxController {
  var longitude = 0.0.obs;
  var latitude = 0.0.obs;

  Future<void> determinePosition() async {
    try {
      Position position = await _determinePosition();
      longitude.value = position.longitude;
      latitude.value = position.latitude;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {}
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
