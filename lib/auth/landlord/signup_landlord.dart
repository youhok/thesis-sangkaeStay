import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/ID_card_upload.dart';
import 'package:sankaestay/rental/widgets/language_dropdown.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';
import 'package:sankaestay/auth/landlord/signin_landlord.dart';

class SignupLandlord extends StatefulWidget {
  const SignupLandlord({super.key});

  @override
  State<SignupLandlord> createState() => _SignupLandlordState();
}

class _SignupLandlordState extends State<SignupLandlord> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Column(
        children: [
          // Top bar with language selector and back button
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            color: AppColors.primaryBlue,
            child: Row(
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.only(top: 45, left: 20),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Spacer(),
                // Language dropdown
                Padding(
                  padding: const EdgeInsets.only(top: 45, right: 20),
                  child: LanguageDropdown(),
                ),
              ],
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      SvgPicture.asset('images/logo_blue.svg', height: 110),
                      const SizedBox(height: 20),
                      const Text(
                        'Sign Up as Landlord',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: "Name",
                        hintText: "Enter your name",
                        controller: _nameController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: "Email",
                        hintText: "Enter your email",
                        controller: _emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: "Phone Number",
                        hintText: "Enter your phone number",
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        label: "Password",
                        hintText: "Enter your password",
                        obscureText: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 10),
                      IDCardUploadWidget(
                        onUpload: () {
                          // Add file upload logic here
                        },
                        file: null,
                      ),

                      // sign up button
                      Custombutton(
                        onPressed: () {
                          // Add sign up logic here
                        },
                        text: "Sign Up",
                      ),
                      const SizedBox(height: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninLandlord(),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
