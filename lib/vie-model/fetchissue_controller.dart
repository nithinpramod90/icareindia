import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/views/presentation/describeissue_screen.dart';

void fetchIssueDetails(String id) async {
  final ApiService apiService = ApiService();
  final result = await apiService.sendissue(id);
  if (result['success']) {
    final maincat = result['maincat'];
    final subcat = result['subcat'];
    print(maincat);
    print(subcat);
    Get.to(
      IssueScreen(),
      arguments: {
        'maincat': maincat,
        'subcat': subcat,
      },
    );
  } else {
    // Handle error
    Get.snackbar('Error', result['message']);
  }
}
