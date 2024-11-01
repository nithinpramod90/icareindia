import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/components/appbar.dart';
import 'package:icareindia/model/components/bottom_nav_bar.dart';
import 'package:icareindia/vie-model/location_fetch_controller.dart';
import 'package:icareindia/vie-model/subcategory_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  final SubcategoryController controller = Get.put(SubcategoryController());

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationFetchController());

    locationController.loadSavedLocationAndCategories();
    // Retrieve the arguments passed from the previous screen
    // Extract categories, name, and address from the arguments
    final List<Map<String, dynamic>> categories =
        locationController.categoryController.categories;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(isHomePage: true),
      body: SingleChildScrollView(
        // Make the entire body scrollable
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello ${locationController.name.value}",
              style: const TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "What do you need help with?",
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Service’s we Provide",
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 18),
            // Wrap GridView with a Container and set a maximum height
            categories.isEmpty
                ? const Center(child: Text('No data found'))
                : SizedBox(
                    // Set a max height for the grid
                    height: MediaQuery.of(context).size.height / 1.55,
                    child: buildCategoryGrid(categories),
                  ),
          ],
        ),
      ), // Show grid when data is loaded
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget buildCategoryGrid(List<Map<String, dynamic>> categories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () async {
            await controller.getSubcategories(category['id'].toString());
            // Print the id when the category tile is pressed
            print('Category ID: ${category['id'].toString()}');
          },
          child: Card(
            color: Colors.white,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius:
                    BorderRadius.circular(10.0), // Match border radius
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(
                      category['image'],
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 4,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: Colors.red);
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    category['categoryname'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
