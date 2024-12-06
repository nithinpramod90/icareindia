import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/config.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/vie-model/service_controller.dart';
import 'package:icareindia/views/presentation/servicedetail_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:icareindia/model/components/bottom_nav_bar.dart';

class ServiceScreen extends StatelessWidget {
  final ServiceController controller = Get.put(ServiceController());
  final ApiService apiService = ApiService();
  ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Services',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Lottie.asset('assets/images/loader.json',
                width: 100, height: 100),
          );
        } else if (controller.upcomingServices.isEmpty &&
            controller.previousServices.isEmpty) {
          return const Center(
            child: Text(
              'No data found',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upcoming Services',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                controller.upcomingServices.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.upcomingServices.length,
                        itemBuilder: (context, index) {
                          final service = controller.upcomingServices[index];
                          final imageurl = service['image'];
                          return GestureDetector(
                            onTap: () async {
                              final String id = service['id'].toString();
                              navigateToServiceCostScreen(id);
                            },
                            child: ServiceCard(
                              imageUrl: "${AppConfig.baseUrl}$imageurl",
                              title: service['name'],
                              subtitle:
                                  '${service['status']} / ${service['time']}',
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('No upcoming services')),
                const SizedBox(height: 16),
                const Text(
                  'Previous Services',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                controller.previousServices.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.previousServices.length,
                        itemBuilder: (context, index) {
                          final service = controller.previousServices[index];
                          final imageurl = service['image'];
                          return GestureDetector(
                            onTap: () async {
                              final String id = service['id'].toString();
                              navigateToServiceCostScreen(id);
                            },
                            child: ServiceCard(
                              imageUrl: "${AppConfig.baseUrl}$imageurl",
                              title: service['name'],
                              subtitle:
                                  '${service['status']} / ${service['time']}',
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('No previous services')),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  void navigateToServiceCostScreen(String id) async {
    final ApiService apiService = ApiService();
    final serviceDetails = await apiService.servicesdetail(id);

    if (serviceDetails != null) {
      print(serviceDetails['id']);
      Get.to(
        ServiceCostScreen(
          details: serviceDetails,
        ),
      );
    } else {
      print(
          "     hfghdsgfhdsfhgsdfgshdgfhsdgfhsdgfhgsdhfgdshgfhdsgfhgsdjhfgshdgfsdgfshdgfsgdfhgsdfghsdgfhjsdgfjsd");
    }
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(imageUrl, width: 40, height: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 10,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_right),
              onPressed: () {
                // Add delete action here
              },
            ),
          ],
        ),
      ),
    );
  }
}
