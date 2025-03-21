import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Dropdown_Field.dart';
import 'package:sankaestay/rental/widgets/phone_number_input.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';

class EditProfileTenants extends StatefulWidget {
  const EditProfileTenants({super.key});

  @override
  State<EditProfileTenants> createState() => _EditProfileTenantsState();
}

class _EditProfileTenantsState extends State<EditProfileTenants> {
  @override
  Widget build(BuildContext context) {
    String gender = 'Male';
    TextEditingController phoneController = TextEditingController();
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
                          Center(
                            child: ProfileAvatar(
                              imagePath:
                                  'images/person.png', // Replace with your image asset path
                              onEdit: () {
                                print("Edit button clicked");
                              },
                            ),
                          ),
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
                            onChanged: (value) =>
                                setState(() => gender = value!),
                          ),
                          const SizedBox(height: 10),

                          // Telegram Username Field
                          CustomTextField(
                            label: "Telegram Phone Number/Username (Optional)",
                            hintText: "@heng_youhok",
                          ),
                          const SizedBox(height: 10),
                          PhoneNumberInput(controller: phoneController),
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

class ProfileAvatar extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onEdit;

  const ProfileAvatar({
    super.key,
    required this.imagePath,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 55,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
