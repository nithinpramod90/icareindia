import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/model/components/snackbar.dart';

class TextInputPopup extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String id;

  TextInputPopup({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Enter Your Issue',
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Type something...',
              hintStyle: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            final ApiService apiService = ApiService();
            // Handle the continue button action
            String inputText = controller.text;
            if (inputText.isNotEmpty) {
              await apiService.ticket(inputText, id);
              Get.back(result: inputText); // Return the input text
            } else {
              Get.snackbar('Error', 'Please enter some text');
            }
          },
          child: Text('Continue'),
        ),
      ],
    );
  }
}
