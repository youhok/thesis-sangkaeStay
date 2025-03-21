import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sankaestay/util/constants.dart';

class Verification extends StatelessWidget {
  Verification({super.key});

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            color: const Color(0xFF001D57),
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
                    // Logo
                    SvgPicture.asset(
                      'images/logo_blue.svg', // Replace with your asset path
                      height: 110,
                    ),
                    const SizedBox(height: 20),
                    // Title
                    const Text(
                      'Verifications',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    // Subtitle
                    const Text(
                      '6-digits pin has been sent to your email address.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    // Code Verification Label
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Code verification',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                if (index < 5) {
                                  _focusNodes[index + 1].requestFocus();
                                } else {
                                  _focusNodes[index].unfocus(); // Last field
                                }
                              }
                            },
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 30),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle verification
                          String otp = _controllers
                              .map((controller) => controller.text)
                              .join();
                          print('Entered OTP: $otp'); // Debug
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF001D57),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
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
