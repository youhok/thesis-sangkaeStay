import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/invoice_card.dart';
import 'package:sankaestay/util/constants.dart';


class InvoiceDetails extends StatelessWidget {
  const InvoiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "invoice_detail.title".tr,
      child: Stack(
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
                      Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: InvoiceCard(
                            avatarText: 'KHQR',
                            name: 'Morm Borenn',
                            amount: 'xx.xx \$',
                            roomId: '10',
                            propertyId: '1234',
                            receiptId: '18374',
                            receiptDate: '10/09/2024',
                            waterUsage: 'xx.xx',
                            electricityUsage: 'xx.xx',
                            garbage: '0',
                            internet: '0',
                            paymentStatus: 'false',
                            rentType: 'contract',
                            payDate: '13/09/2024',
                            landlordContact: '096 712 213',
                            companyName: 'SangkaeStay',
                            companyTagline: 'Find rent & manage',
                            logoPath:
                                'images/logo_blue.svg', // Replace with your asset path
                          ),
                          ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(AppIcons.delete,
                                    size: 30, color: Colors.grey),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(AppIcons.share,
                                    size: 30, color: Colors.grey),
                                onPressed: () {},
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
        ],
      ),
    );
  }
}
