import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/config.dart';
import 'package:icareindia/model/components/dailer.dart';
import 'package:icareindia/vie-model/payment_controller.dart';
import 'package:icareindia/views/presentation/home_screen.dart';

import '../../model/components/raise_ticket.dart';

class ServiceCostScreen extends StatelessWidget {
  final Map<String, dynamic> details;
  final PaymentController paymentController = Get.put(PaymentController());

  ServiceCostScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    bool isUpcoming = details['upcoming'] ?? true;
    String buttonText = isUpcoming ? 'Pay' : 'Continue';
    const String url = AppConfig.baseUrl;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Service Details",
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                      child: Image.network('$url${details['image']}'),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      '${details['maincat']}',
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
                  '${details['subcat']}',
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  '${details['description']}',
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(height: 20),
              const Text(
                'Technician Details',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Network Image
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('$url${details['techimage']}'),
                      radius: 24.0,
                    ),

                    // Name Text
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          '${details['techname']}',
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // Call Button
                    IconButton(
                      onPressed: () {
                        print("$url${details['techimage']}");
                        dialerButton(
                          "${details['techcontact']}",
                        );
                      },
                      icon: const Icon(Icons.call, color: Colors.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Details',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Spare',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${details['spare']}',
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Service cost',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '${details['service']}',
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${details['total']}',
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 18),
              GestureDetector(
                onTap: () {
                  print("Raise an Issue");
                },
                child: InkWell(
                  onTap: () async {
                    final String id = await details['id'].toString();
                    print(id);
                    String? result = await Get.dialog(TextInputPopup(
                      id: id,
                    ));
                    if (result != null) {
                      // Do something with the input text
                      Get.snackbar(
                          'Issue Registered sucessfully', 'Callback Requested');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Raise a Ticket',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'If you have any issue raise a ticket',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 18,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (isUpcoming) {
                      paymentController.payNow("${details['id']}");
                    } else {
                      Get.off(() => HomeScreen());
                    }
                  },
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void handlePayAction() async {
  //   print("upcoming");
  //   paymentController.payNow;
  // }

  // void handleContinueAction() {
  //   paymentController.payNow;
  //   print("finished");

  //   // Logic for continue action
  // }
}
