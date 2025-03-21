import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/language_dropdown.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001D57),
      body: Column(
        children: [
          // Top bar with language selector
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            color: const Color(0xFF001D57),
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
                      'Forget Password',
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
                    SizedBox(
                      height: 20,
                    ),
                    Custombutton(onPressed: () {}, text: "Continue"),
                    SizedBox(
                      height: 380,
                    ),
                 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const Text(
                          'Sign In',
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