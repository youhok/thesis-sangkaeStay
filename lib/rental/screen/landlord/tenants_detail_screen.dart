// Tenants_detail
import 'package:flutter/material.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/Custom_Icon_button.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/receipt_card.dart';
import 'package:sankaestay/util/constants.dart';

class TenantsDetailScreen extends StatelessWidget {
  TenantsDetailScreen({super.key});
  final List<Map<String, dynamic>> receipts = [
    {
      'month': 'August 2024',
      'receiptNo': '5812',
      'electricity': '27 kwh',
      'water': '3 m3',
      'internet': '0 \$',
      'garbage': '0 \$',
      'paid': false,
      'total': '65.0\$'
    },
    {
      'month': 'September 2024',
      'receiptNo': '5812',
      'electricity': '27 kwh',
      'water': '3 m3',
      'internet': '0 \$',
      'garbage': '0 \$',
      'paid': true,
      'total': '65.0\$'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Tenants Details",
       child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGrey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'images/sangkaestay.ico', // Replace with actual image URL
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Borenn Morm',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '0971264873',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Move In: 19/07/2024',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Tenant Info
                          _buildInfoRow('Room ID:                 ', '01'),
                          _buildInfoRow('Property ID:            ', '01'),
                          _buildInfoRow('Gender:', '                    Male'),
                          _buildInfoRow(
                              'Date of Birth:', '          28/08/2001'),
                          _buildInfoRow('Profession:', '              Student'),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Move Out",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              CustomIconButton(
                                  icon: AppIcons.phone, onPressed: () {}),
                              SizedBox(
                                width: 20,
                              ),
                              CustomIconButton(
                                  icon: AppIcons.telegram, onPressed: () {}),
                              SizedBox(
                                width: 20,
                              ),
                              CustomIconButton(
                                  icon: AppIcons.badge , onPressed: () {}),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Column(
                            children: receipts
                                .map((receipt) =>
                                    ReceiptCard(receiptData: receipt))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Edit Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0B1F4E), // Dark Blue
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        SizedBox(width: 16), // Space between buttons
                        // Generate Receipt Button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0B1F4E), // Dark Blue
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'Generate Receipt',
                            style: TextStyle(color: Colors.white, fontSize: 16),
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


Widget _buildInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

