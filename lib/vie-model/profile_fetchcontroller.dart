import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';

class ProfileScreenController extends GetxController {
  final ApiService apiService = ApiService();
  var isLoading = true.obs;
  var profileData = {}.obs; // Observable to hold profile data

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() async {
    isLoading(true); // Show loader
    final data = await apiService.fetchUserData();
    if (data != null) {
      profileData.value = data;
    }
    isLoading(false); // Hide loader
  }
}
