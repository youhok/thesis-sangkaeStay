//Tenants screen

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/screen/landlord/addtenants_screen.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/util/constants.dart';

class TenantsScreen extends StatelessWidget {
  const TenantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for tenants
    final List<Map<String, dynamic>> tenants = [
      {
        'imageUrl':
            'https://via.placeholder.com/150', // Replace with actual image URL
        'name': 'John Doe',
        'phone': '+123 456 7890',
        'roomId': 'R101',
        'propertyId': 'P202'
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'name': 'Jane Smith',
        'phone': '+987 654 3210',
        'roomId': 'R102',
        'propertyId': 'P203'
      }
    ]; // Empty for now

    return BaseScreen(
      title: "tenant.title".tr, 
      child: Stack(
        children: [
          Column(
            children: [
              // Search Field and List View combined
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
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'tenant.placeholders'.tr,
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: AppColors.secondaryBlue,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      tenants.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(top: 200),
                              child: Center(
                                child: Image.asset(
                                  "images/undraw_no-data_ig65-removebg-preview.png",
                                  height: 250,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      "Image not found",
                                      style: TextStyle(color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: tenants.length,
                                itemBuilder: (context, index) {
                                  final tenant = tenants[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: const BorderSide(
                                          color: Colors.grey, // Black border color
                                          width: 1.0, // Border width
                                        ),
                                      ),
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Profile Image
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      50), // Circular image
                                              child: Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: Image.network(
                                                  tenant['imageUrl'],
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                        Icons.person,
                                                        size: 60,
                                                        color: Colors.grey);
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),

                                            // Tenant Information
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Tenant Name
                                                  Text(
                                                    tenant['name'],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black87,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  // Tenant Phone
                                                  Text(
                                                    tenant['phone'],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  // Room ID and Property ID
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Room ID: ${tenant['roomId']}",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey[700],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 1),
                                                      Expanded(
                                                        child: Text(
                                                          "Property ID: ${tenant['propertyId']}",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors
                                                                .grey[700],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating Action Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Navigate to add tenant screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTenantsScreen()));
              },
              backgroundColor: AppColors.primaryBlue,
              child: const Icon(AppIcons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      );
  }
}


