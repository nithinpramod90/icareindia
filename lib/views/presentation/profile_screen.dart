import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icareindia/model/api/mobile_api.dart';
import 'package:icareindia/model/components/bottom_nav_bar.dart';
import 'package:icareindia/model/components/delete_account.dart';
import 'package:icareindia/vie-model/profile_fetchcontroller.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());
  final ApiService apiService = ApiService();

  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.person, color: Colors.black),
            SizedBox(width: 10),
            Text(
              'Account',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(
            child: SizedBox(
                width: Get.width / 6,
                height: Get.height / 6,
                child: Lottie.asset(
                    'assets/images/loader.json')), // Your Lottie loader
          );
        }

        final data = profileController.profileData;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
                child: Image.asset("assets/images/avathar.png"),
              ),
              const SizedBox(height: 10),
              Text(
                data['name'] ?? '-',
                style: const TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              ProfileInfoRow(
                  label: 'Mobile Number', value: data['phone'] ?? '-'),
              ProfileInfoRow(label: 'Gender', value: data['gender'] ?? '-'),
              ProfileInfoRow(
                  label: 'Alternate Number', value: data['alt_phone'] ?? '-'),
              const SizedBox(height: 25),
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "Account settings",
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              // AccountSettingsOption(
              //   label: 'Edit Profile',
              //   onTap: () {},
              // ),
              AccountSettingsOption(
                label: 'Delete Account',
                onTap: () {
                  showDeleteAccountDialog();
                },
              ),
              AccountSettingsOption(
                label: 'Logout',
                onTap: () {
                  apiService.logout();
                },
                isLogout: true,
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class AccountSettingsOption extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLogout;

  const AccountSettingsOption({
    super.key,
    required this.label,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Urbanist',
          color: isLogout ? Colors.red : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label :',
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
