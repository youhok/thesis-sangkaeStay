import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/status_card.dart';
import 'package:sankaestay/util/constants.dart';

class Booking extends StatelessWidget {
  Booking({super.key});
  final List<Map<String, String>> approvedApplicants = [
    {
      "name": "Roth Thida",
      "phone": "091 274 3653",
      "moveIn": "28/02/2025",
      "status": "Pending",
      "image": "images/person.png",
      "profession": "Student",
      "address": "ភូមិស្នោ ឃុំស្នោ ស្រុកកណ្ដាលស្ទឹង ខេត្តកំពង់ឆ្នាំង",
      "telegram": "null",
      "rentType": "Contract",
      "rentDuration": "5 months",
      "createAt": "24/01/2025 09:30 PM",
      "moveOut": "28/07/2025"
    }
  ];

  final List<Map<String, String>> rejectedApplicants = [];
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Bookings",
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Center(child: StatusRow()),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: const [
                Text(
                  "Approved",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: approvedApplicants.isEmpty
                ? Center(
                    child: Image.asset(
                      "images/undraw_no-data_ig65-removebg-preview.png",
                      height: 260,
                    ),
                  )
                : ListView.builder(
                    itemCount: approvedApplicants.length,
                    itemBuilder: (context, index) {
                      final tenant = approvedApplicants[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset(tenant['image']!),
                            ),
                            title: Text(
                              tenant['name']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlue),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tenant['phone']!),
                                Text("Move In: ${tenant['moveIn']!}"),
                                Text("Status: ${tenant['status']!}"),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (context) {
                                  return BookingDetailsModal(tenant: tenant);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class StatusRow extends StatelessWidget {
  const StatusRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        StatusCard(label: "Pending", count: 2, color: Colors.grey),
        SizedBox(width: 10),
        StatusCard(label: "Approved", count: 5, color: Colors.green),
        SizedBox(width: 10),
        StatusCard(label: "Rejected", count: 0, color: Colors.red),
      ],
    );
  }
}

class BookingDetailsModal extends StatelessWidget {
  final Map<String, String> tenant;

  const BookingDetailsModal({super.key, required this.tenant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 24,
                  child: ClipOval(
                    child: SizedBox(
                      width: 48, // Ensure image fills the CircleAvatar
                      height: 48,
                      child: Image.asset(
                        tenant['image']!,
                        fit: BoxFit
                            .cover, // Ensures the image fills the space properly
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenant['name']!,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue),
                    ),
                    Row(
                      children: [
                        Text(tenant['phone']!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54)),
                        const SizedBox(width: 6),
                        const Icon(Icons.phone, size: 16, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(tenant['status']!,
                      style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 5),
            _buildInfoRow("Profession", tenant['profession']!),
            _buildInfoRow("Address", tenant['address']!),
            _buildInfoRow("Telegram", tenant['telegram']!),
            _buildInfoRow("Rent Type", tenant['rentType']!),
            _buildInfoRow("Rent Duration", tenant['rentDuration']!),
            _buildInfoRow("Create At", tenant['createAt']!),
            _buildInfoRow("Move In", tenant['moveIn']!),
            _buildInfoRow("Move Out", tenant['moveOut']!),
            const SizedBox(height: 5),
            const Text("ID Card",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: 180,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6), // Reduce roundness
                      ),
                    ),
                    child: const Text("Reject",
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6), // Reduce roundness
                      ),
                    ),
                    child: const Text("Approve",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2, // Adjust width ratio
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 2), // Space between label and value
          Expanded(
            flex: 4, // Adjust width ratio
            child: Text(
              ": $value",
              style: const TextStyle(color: Colors.black54),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
