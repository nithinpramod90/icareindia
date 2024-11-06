import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';

class ServiceController extends GetxController {
  final ApiService apiService = ApiService();
  var upcomingServices = <Map<String, dynamic>>[].obs;
  var previousServices = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  void fetchServices() async {
    isLoading.value = true;
    try {
      final data = await apiService.services();
      upcomingServices.value = data?['upcoming'] ?? [];
      previousServices.value = data?['previous'] ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Could not load services');
    } finally {
      isLoading.value = false;
    }
  }
}
