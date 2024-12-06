import 'package:flutter/material.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:intl/intl.dart';

class TimeSlotScreen extends StatefulWidget {
  final int startHour = 9; // Working hours start at 9 AM
  final int endHour = 19; // Working hours end at 7 PM (24-hour format)
  final String id;

  const TimeSlotScreen({
    super.key,
    required this.id,
  });

  @override
  _TimeSlotScreenState createState() => _TimeSlotScreenState();
}

class _TimeSlotScreenState extends State<TimeSlotScreen> {
  String? selectedTime;

  List<String> _generateTimeSlots() {
    final now = DateTime.now();
    int currentHour = now.hour;

    // If it's past the working hours, return an empty list
    if (currentHour >= widget.endHour) {
      return [];
    }

    // Start from the next hour if within working hours
    int firstSlot =
        currentHour < widget.startHour ? widget.startHour : currentHour + 1;

    // Generate time slots
    List<String> slots = [];
    for (int hour = firstSlot; hour < widget.endHour; hour++) {
      final time = DateTime(now.year, now.month, now.day, hour);
      slots.add(DateFormat('hh:mm a').format(time));
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = _generateTimeSlots();
    final ApiService apiService = ApiService();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Time Slot",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: timeSlots.isEmpty
          ? const Center(
              child: Text(
                "No available time slots.",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        final time = timeSlots[index];
                        final isSelected = time == selectedTime;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.grey[100]
                                  : Colors.grey[850],
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              time,
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey[300],
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: selectedTime == null
                        ? null
                        : () {
                            apiService.prefferedtime(widget.id, selectedTime!);
                            // Handle confirmation action
                            print("$selectedTime Time slot confirmed");
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 20),
                      backgroundColor: Colors.black, // background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
