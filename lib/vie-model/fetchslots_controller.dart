import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/views/presentation/slots_screen.dart';

class SlotsController extends GetxController {
  final ApiService apiService = ApiService();

  Future<void> loadSlots() async {
    try {
      final result = await apiService.fetchslots();
      if (result['success']) {
        // Ensure 'schedules' has a default value if it’s null or missing
        final schedules = result['schedules'] ?? [];

        // Navigate to SlotsScreen with the schedule data
        Get.to(
          () => const SlotsScreen(),
          arguments: {
            'schedules': schedules,
          },
        );
      } else {
        // Show error message if 'success' is false
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      // Log error for debugging
      print('Error in loadSlots: $e');
      Get.snackbar('Error', 'Failed to load slots');
    }
  }
}
