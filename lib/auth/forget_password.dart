import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/language_dropdown.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Column(
        children: [
          // Top bar with language selector
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            color: AppColors.primaryBlue,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 45, right: 20),
                child: LanguageDropdown(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    SvgPicture.asset('images/logo_blue.svg', height: 110),
                    const SizedBox(height: 20),
                     Text(
                      'forget_password_screen.forgetpassword'.tr,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                        label: "forget_password_screen.label".tr,
                        hintText: "forget_password_screen.placeholder".tr),
                    SizedBox(
                      height: 20,
                    ),
                    Custombutton(onPressed: () {}, text: "forget_password_screen.continue".tr),
                    SizedBox(
                      height: 380,
                    ),
                 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'forget_password_screen.alreadyHaveAccount'.tr,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                         Text(
                          'forget_password_screen.signIn'.tr,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.primaryBlue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}