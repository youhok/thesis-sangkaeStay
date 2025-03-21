import 'package:flutter/material.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Dashed_Line_Painter.dart';

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> receipts = [
      {
        'receiptNo': "31294",
        'name': "Morm Borenn",
        'date': "01 / 01 / 2025",
      },
      {
        'receiptNo': "31294",
        'name': "Morm Borenn",
        'date': "01 / 01 / 2025",
      }
    ]; // Empty for now
    return BaseScreen(title: "Invoice Lists", child:  Stack(
        children: [
          Column(
            children: [
              // Search Field and List View combined
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGrey,
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
                            hintText: 'Search Receipt Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true, // Enable filling color
                            fillColor:
                                Colors.white, // Set background color to white
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
                      receipts.isEmpty
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
                                itemCount: receipts.length,
                                itemBuilder: (context, index) {
                                  final receipt = receipts[index];
                                  return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ReceiptCard(
                                        receiptNo: " ${receipt['receiptNo']} ",
                                        name: "${receipt['name']}",
                                        date: "${receipt['date']}",
                                      ));
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
              },
              backgroundColor: const Color(0xFF0A2658),
              child: const Icon(AppIcons.add, color: Colors.white),
            ),
          ),
        ],
      ),);
  }
}

class ReceiptCard extends StatelessWidget {
  final String receiptNo;
  final String name;
  final String date;

  const ReceiptCard({
    super.key,
    required this.receiptNo,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Receipt Number and Menu Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Receipt No",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      receiptNo,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert,
                      color: Colors.black54, size: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.white, // White background
                  elevation: 2, // Light shadow for subtle effect
                  onSelected: (value) {
                    if (value == 'share') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share clicked')),
                      );
                    } else if (value == 'delete') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Delete clicked')),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'share',
                      height: 30, // Smaller height
                      child: Row(
                        children: const [
                          Icon(Icons.share, color: Colors.black, size: 18),
                          SizedBox(width: 8),
                          Text('Share', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      height: 30, // Smaller height
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: Colors.red, size: 18),
                          SizedBox(width: 8),
                          Text('Delete',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Dashed Divider
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: CustomPaint(
                painter: DashedLinePainter(),
                child: SizedBox(
                  width: double.infinity,
                  height: 1,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Name and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

