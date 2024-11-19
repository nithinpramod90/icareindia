import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/vie-model/search_controller.dart' as se;
import 'package:icareindia/views/presentation/describeissue_screen.dart';

class SearchScreen extends StatelessWidget implements PreferredSizeWidget {
  final se.SearchController controller = Get.put(se.SearchController());

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900], // Dark grey background
        title: TextField(
          onChanged: controller.updateQuery,
          style: const TextStyle(color: Colors.white), // White text color
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle:
                TextStyle(color: Colors.grey[400]), // Light grey hint color
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: controller.printQuery,
          ),
        ],
      ),
      body: Obx(() {
        // Use Obx to reactively display the search results
        if (controller.searchResults.isNotEmpty) {
          return ListView.builder(
            itemCount: controller.searchResults.length,
            itemBuilder: (context, index) {
              final item =
                  controller.searchResults[index]; // Access item directly
              final String name = item['name'] ?? 'No Name'; // Extract the name
              final int id = item['id'] ?? 0; // Extract the id

              return ListTile(
                title: Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onTap: () async {
                  // Print the id when the item is tapped
                  print('Tapped on item with ID: $id');
                  final ApiService apiService = ApiService();
                  final result = await apiService.sendissue(id.toString());
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
                },
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              'No results found.',
              style: TextStyle(color: Colors.black),
            ),
          );
        }
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
