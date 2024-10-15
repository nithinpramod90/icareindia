import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/views/presentation/subcategory_screen.dart';

class SubcategoryController extends GetxController {
  final ApiService apiService = ApiService(); // Inject ApiService
  var isLoading = false.obs;

  Future<void> getSubcategories(String id) async {
    isLoading(true); // Start loading
    try {
      final result = await apiService.fetchSubcategories(id);

      if (result['subcategories'].isNotEmpty) {
        // Prepare the arguments
        final arguments = {
          'subcategories': result['subcategories'],
          'title': result['title']
        };

        // Navigate to Subcategory screen with arguments
        Get.to(() => const SubcategoryScreen(), arguments: arguments);
      } else {
        Get.snackbar('Error', 'Failed to fetch categories.');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('$e Error', 'An unexpected error occurred.');
    } finally {
      isLoading(false); // Stop loading
    }
  }
}
