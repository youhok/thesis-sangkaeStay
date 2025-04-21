import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/util/constants.dart';

class AppDrawer extends StatelessWidget {
  final String selectedItem; // To track the active menu item

  const AppDrawer({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.primaryBlue, // Background color
        child: Column(
          children: [
            // Logo and Title
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Column(
                children: [
                  Image.asset(
                    "images/sangkaestay.ico", // Replace with your logo
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "SangkaeStay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(AppIcons.dashboard, "drawerlandlord.dashboard".tr, selectedItem == "Dashboard"),
                  _buildDrawerItem(AppIcons.home, "drawerlandlord.properties".tr, selectedItem == "Properties"),
                  _buildDrawerItem(AppIcons.people, "drawerlandlord.tenants".tr, selectedItem == "Tenants"),
                  _buildDrawerItem(AppIcons.booking, "drawerlandlord.bookings".tr, selectedItem == "Receipt"),
                  _buildDrawerItem(AppIcons.payments, "drawerlandlord.payments".tr, selectedItem == "Premium"),
                  _buildDrawerItem(AppIcons.settings, "drawerlandlord.settings".tr, selectedItem == "Settings"),
                ],
              ),
            ),
            // Logout Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildDrawerItem(Icons.logout, "drawerlandlord.logout".tr, false, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, bool isSelected, {Color color = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            // Handle navigation logic here
          },
        ),
      ),
    );
  }
}
