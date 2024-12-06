import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/model/components/razorpay_widget.dart';
import 'package:icareindia/model/components/snackbar.dart';

class PaymentController extends GetxController {
  final RazorpayService razorpayService = Get.find<RazorpayService>();
  final ApiService apiService = ApiService();

  void payNow(String id) async {
    final payDetails = await apiService.payment(id);
    bool bill = payDetails?['billed'];
    print(payDetails.toString());
    if (bill == false) {
      razorpayService.openPaymentOptions(
        key: payDetails?['key'],
        amount:
            payDetails?['amount'], // Amount in paise (e.g., 10000 = ₹100.00)
        name: 'iCareIndia',
        description: 'Service Payment',
        contact: payDetails?['contact'],
        email: 'icareindia2@gmail.com',
      );
    } else {
      showCustomSnackbar(
          title: 'Service', message: "Payment will be done only after service");
    }
  }
}
