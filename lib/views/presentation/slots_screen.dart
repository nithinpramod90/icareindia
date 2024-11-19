import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';

class SlotsScreen extends StatefulWidget {
  const SlotsScreen({super.key});

  @override
  _SlotsScreenState createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {
  List<dynamic> schedules = Get.arguments['schedules'] ?? [];
  String id = Get.arguments['id'];
  Map<String, String?> selectedSlots =
      {}; // Store selected time for each date in original format

  // Helper function to format the time slots for display
  String formatTimeSlot(String slot) {
    final period = slot;
    // final hour = slot.replaceAll(RegExp(r'[^\d]'), ''); // Removes 'am' or 'pm'
    return period.toUpperCase();
  }

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Slots'),
      ),
      body: schedules.isNotEmpty
          ? ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                final date = schedule['date'];
                final timeSlots = schedule['timeslots'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Date: $date',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: timeSlots.map<Widget>((originalTime) {
                        final formattedTime = formatTimeSlot(originalTime);
                        return ChoiceChip(
                          label: Text(formattedTime),
                          selected: selectedSlots[date] == originalTime,
                          onSelected: (isSelected) {
                            setState(() {
                              selectedSlots[date] =
                                  isSelected ? originalTime : null;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const Divider(),
                  ],
                );
              },
            )
          : const Center(child: Text('No slots available')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            selectedSlots.forEach((date, time) {
              if (time != null) {
                apiService.sendschedule(date, time, id);
              }
            });
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
