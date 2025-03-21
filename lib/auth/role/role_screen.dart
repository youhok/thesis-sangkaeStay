import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/util/constants.dart';
// Import for SVG images

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue, // Dark blue background
      body: Column(
        children: [
          // Top Blue Section
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            color: AppColors.primaryBlue,
          ),
          // Content Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ), // Spacing for top padding

                  // Logo Section
                  SvgPicture.asset(
                    'images/logo_blue.svg', // Replace with your asset path
                    height: 110,
                  ),
                  const SizedBox(height: 20),

                  // Title Section
                  const Text(
                    'Who are you?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Please select your role to proceed and explore tailored features designed just for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Role Buttons Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Landlord Button
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to landlord screen
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding:  const EdgeInsets.only(right: 20 , left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Landlord',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      "Manage your own properties",
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    )
                                  ],
                                ),
                                Icon(AppIcons.arrowforward,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Tenant Button
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to tenant screen
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20 , left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tenants',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    Text(
                                      'Log in to your rental account',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Icon(AppIcons.arrowforward,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
