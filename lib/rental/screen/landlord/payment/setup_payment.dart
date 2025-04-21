import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/custom_search_field.dart';
import 'package:sankaestay/util/constants.dart';

class SetupPayment extends StatelessWidget {
  const SetupPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(AppIcons.arrowback, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          "payments.title".tr,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
           Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Text(
              "payments.set_up_bakong".tr,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 300, // Adjusted height
            // Adjust width to fit the screen
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Image.asset(
              'images/bakong.png',
              fit: BoxFit.cover, // Keeps full image without cropping
              // Align image to top
            ),
          ),
          const SizedBox(height: 60),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("payments.Bakong_account_id".tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  CustomSearchField(
                    hintText: "your_name@xyz",
                  ),
                  const Spacer(),
                  Custombutton(onPressed: () {}, text: "Confirm")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
