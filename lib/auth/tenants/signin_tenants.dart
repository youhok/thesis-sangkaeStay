import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/button_ggle.dart';
import 'package:sankaestay/rental/widgets/language_dropdown.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';

class SigninTenants extends StatelessWidget {
  const SigninTenants({super.key});

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
                      'signin_tenant.signInAsTenant'.tr,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                        label: "signin_tenant.phoneOrEmail".tr,
                        hintText: "signin_tenant.enterPhoneOrEmail".tr),
                    const SizedBox(height: 10),
                    CustomTextField(
                        label: "signin_tenant.password".tr, hintText: "signin_tenant.enterPassword".tr),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment
                          .centerRight, // Aligns the child to the right
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // Ensures text is aligned right
                          children: [
                            Text(
                                "signin_tenant.forgotPassword".tr , style: TextStyle(color: Colors.grey , fontSize: 15 , ), ), // No need for an extra Row
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Custombutton(onPressed: () {}, text: "signin_tenant.signIn".tr),
                     SizedBox(
                      height: 20,
                    ),
                     Center(
                      child: Text("signin_tenant.orSignUpWithGmail".tr ,style: TextStyle(color: Colors.grey , fontSize: 17),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                      GoogleSignUpButton(
                      onPressed: () {
                        // Add Google sign-in logic here
                      },
                    ),
                     SizedBox(
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'signin_tenant.alreadyHaveAccount'.tr,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                         Text(
                          'signin_tenant.signUp'.tr,
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