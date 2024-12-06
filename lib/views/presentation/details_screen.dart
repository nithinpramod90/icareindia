import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/components/snackbar.dart';
import 'package:icareindia/vie-model/profile_controller.dart';

class CreateProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Added Form key

  CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            // Added Form widget
            key: _formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your house/flat/block number';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pin code';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: MediaQuery.of(context).size.height / 14,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate form and show Snackbar if validation fails
                        if (_formKey.currentState!.validate()) {
                          ProfileController profileController = Get.find();
                          await profileController.sendProfileData();
                        } else {
                          showCustomSnackbar(
                              title: 'Error',
                              message: "Fill the form correctly");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Create Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
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
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
