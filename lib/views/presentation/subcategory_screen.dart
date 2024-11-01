import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/vie-model/fetchissue_controller.dart';

class SubcategoryScreen extends StatelessWidget {
  const SubcategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final List<dynamic> subcategories = args['subcategories'] ?? [];
    final String title = args['title'] ?? 'No Title';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          final subcategory = subcategories[index];
          return ListTile(
            title: Text(
              subcategory['categoryname'] ?? 'No Name',
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              subcategory['description'] ?? 'No Description',
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              fetchIssueDetails(subcategory['id'].toString());
              print('${subcategory['id']} tapped');
            },
          );
        },
      ),
    );
  }
}
