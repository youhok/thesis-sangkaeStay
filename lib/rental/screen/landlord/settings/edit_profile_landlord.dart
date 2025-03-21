import 'package:flutter/material.dart';

import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Dropdown_Field.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';

class EditProfileLandlord extends StatefulWidget {
  const EditProfileLandlord({super.key});

  @override
  State<EditProfileLandlord> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileLandlord> {
  String gender = 'Male';
  String selectedCountry = 'KH (+855)'; // Default country
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Edit Profile", 
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
                          ProfileWithDeleteButton(),
                          const SizedBox(height: 10),
                          // First Name Field
                          CustomTextField(
                              label: "First Name", hintText: "First Name"),
                          const SizedBox(height: 10),
                      
                          // Last Name Field
                          CustomTextField(
                              label: "Last Name", hintText: "Last Name"),
                          const SizedBox(height: 10),
                      
                          // Gender Dropdown
                          CustomDropdownField(
                            label: "Gender",
                            options: ['Male', 'Female'],
                            selectedValue: gender,
                            onChanged: (value) => setState(() => gender = value!),
                          ),
                          const SizedBox(height: 10),
                      
                          // Telegram Username Field
                          CustomTextField(
                            label: "Telegram Phone Number/Username (Optional)",
                            hintText: "@heng_youhok",
                          ),
                          const SizedBox(height: 10),
                      
                          // Phone Number Input Field
                          const Text(
                            'Phone Number',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                      
                          Row(
                            children: [
                              // Phone Input Field
                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: '968225617',
                                    contentPadding:
                                        const EdgeInsets.symmetric(vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Flag Image
                                          Image.asset(
                                            'images/cambodiaflag.png', // Ensure the flag is in assets
                                            width: 30,
                                          ),
                                          const SizedBox(width: 5),
                      
                                          // Country Code
                                          const Text(
                                            'KH (+855)',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                      
                              // Refresh Button
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors
                                      .primaryBlue, // Dark blue background
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  icon:
                                      const Icon(Icons.sync, color: Colors.white),
                                  onPressed: () {
                                    // Add refresh functionality here
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Custombutton(onPressed: () {}, text: "Save")
                        ],
                      ),
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



class ProfileWithDeleteButton extends StatelessWidget {
  const ProfileWithDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Profile Image
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryBlue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'images/person.png', // Replace with your image
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Delete Button

        Container(
          margin: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.delete, color: AppColors.secondaryBlue),
            onPressed: () {
              // Handle delete action
            },
          ),
        ),
      ],
    );
  }
}
