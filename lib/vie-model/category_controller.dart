// import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';

class CategoryController extends GetxController {
  final ApiService apiService = ApiService();
  var categories = <Map<String, dynamic>>[].obs; // Observable list
  var isLoading = true.obs; // Observable for loading


  Future<void> fetchCategories() async {
    try {
      isLoading(true); // Show loading state
      categories.value =
          await apiService.fetchCategories(); // Fetch categories from API
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to load categories: $e');
    } finally {
      isLoading(false); // Hide loading state
    }
  }

  void refreshCategories() {
    fetchCategories(); // Refresh categories
  }
}
