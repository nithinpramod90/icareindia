import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/vie-model/profile_controller.dart';

class CreateProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              const Center(
                child: Text(
                  'Create Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.normal,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 17),
              const Text(
                "Add Detail's",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => DropdownButtonFormField<String>(
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w100,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: controller.selectedGender.value.isEmpty
                        ? null
                        : controller.selectedGender.value,
                    items: ['Male', 'Female', 'Other']
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      controller.setGender(value!);
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  hintText: 'John Doe',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: controller.setName,
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'Alternate Number',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  hintText: '+91 00000 00000 (Optional)',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.phone,
                onChanged: controller.setAlternateNumber,
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 17),
              const Text(
                "Address",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'House / Flat / Block No',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: controller.sethousename,
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'Urbanist',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: controller.setcity,
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'State',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'Urbanist',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: controller.setstate,
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: 'Pin Code',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'Urbanist',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: controller.setpostalcode,
              ),
              const SizedBox(
                height: 18,
              ),
              const Center(
                child: Text(
                  'Your Privacy is Our Priority. We safeguard your personal information with the highest standards of security and confidentiality.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 18,
              ),
              const SizedBox(height: 25),

              // const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    print("button done");
                    ProfileController profileController = Get.find();

                    // Call the sendProfileData method to send the data to the API
                    await profileController.sendProfileData();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'iCareIndia',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
