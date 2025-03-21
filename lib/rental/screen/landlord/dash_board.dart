//screen dashboard for controller tenants
import 'package:flutter/material.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/App_Drawer.dart';
import 'package:sankaestay/util/constants.dart';
// Import your AppDrawer widget

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      drawer: AppDrawer(selectedItem: "Dashboard"), // Add the drawer here
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        leading: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(AppIcons.menu, color: Colors.white, size: 30),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              ),
            ),
            const SizedBox(width: 5), // Adjust spacing between icon and text
            const Text(
              'Dashboard',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leadingWidth: 180,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Handle notifications
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard('0', 'Total Property', Colors.blue,
                                Icons.apartment),
                            _buildStatCard(
                                '0', 'Total Tenants', Colors.red, Icons.person),
                            _buildStatCard('0', 'Renewal Tenants', Colors.green,
                                Icons.money),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Renews Tenants',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        tenants.isEmpty
                            ? Container(
                                margin: EdgeInsets.only(top: 165),
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
                                      padding: const EdgeInsets.all(0.0),
                                      child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: const BorderSide(
                                            color: Colors
                                                .grey, // Black border color
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
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Image.network(
                                                    tenant['imageUrl'],
                                                    width: 60,
                                                    height: 60,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
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
                                                        const SizedBox(
                                                            width: 1),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildStatCard(String count, String label, Color color, IconData icon) {
  return Container(
    width: 125,
    height: 120,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                icon,
                size: 24,
                color: Colors.white,
              ),
            ],
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
