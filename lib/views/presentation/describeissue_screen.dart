import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/config.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/model/components/audio/audioFeatureWidget.dart';
import 'package:icareindia/vie-model/fetchslots_controller.dart';

class IssueScreen extends StatelessWidget {
  IssueScreen({super.key});
  final TextEditingController issueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final url = Uri.parse(AppConfig.baseUrl);
    final ApiService apiService = ApiService();
    // final SlotsController slotsController = Get.put(SlotsController());

    final Map<String, dynamic> maincat = Get.arguments['maincat'];
    final Map<String, dynamic> subcat = Get.arguments['subcat'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Describe Issue",
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius:
                    BorderRadius.circular(10.0), // Match border radius
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 11,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Image.network('$url${maincat['image']}'),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Text(
                    '${maincat['categoryname']}',
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Issue",
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            ListTile(
              title: Text(
                '${maincat['categoryname']}',
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '${subcat['description']}',
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Describe Your Issue",
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6, // Dynamic height
              padding: const EdgeInsets.symmetric(
                  horizontal: 16), // Optional padding
              decoration: BoxDecoration(
                color: Colors.grey[300], // Grey background
                borderRadius: BorderRadius.circular(12), // Curved border
                border: Border.all(
                  color: Colors.black, // Black border
                  width: 2, // Border thickness
                ),
              ),
              child: Center(
                child: TextFormField(
                  controller: issueController,

                  expands: true, // Expands to fill the container
                  maxLines: null, // Allows for dynamic height with expands
                  minLines: null,
                  decoration: const InputDecoration(
                    isDense: true, // Reduces padding inside the field
                    border: InputBorder.none, // Removes default border
                    hintText: 'Enter text',
                    hintStyle: TextStyle(
                      color: Colors.black45,
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  cursorColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "OR",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AudioFeatureWidget(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final issueText = issueController.text;

                  await apiService.registerissue(
                      issueText, subcat['id'].toString());
                  await apiService.fetchslots();
                  final slotsController = SlotsController();
                  slotsController.loadSlots();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  backgroundColor: Colors.black, // background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Place Service",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
