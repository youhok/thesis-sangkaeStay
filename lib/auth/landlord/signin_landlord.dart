import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/language_dropdown.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';

class SigninLandlord extends StatelessWidget {
  const SigninLandlord({super.key});

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
                    const Text(
                      'Sign In as Landlord',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                        label: "Phone Number /Email",
                        hintText: "Enter you phone number or email"),
                    const SizedBox(height: 10),
                    CustomTextField(
                        label: "Password", hintText: "Enter your password"),
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
                                "Forget Password ?" , style: TextStyle(color: Colors.grey , fontSize: 15 , ), ), // No need for an extra Row
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Custombutton(onPressed: () {}, text: "Sign In"),
                    SizedBox(
                      height: 250,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const Text(
                          'Sign Up',
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
