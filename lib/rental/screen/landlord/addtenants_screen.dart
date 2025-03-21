//add tenants Screen
import 'package:flutter/material.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Date_Picker.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Dropdown_Field.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Image_Upload.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';

class AddTenantsScreen extends StatefulWidget {
  const AddTenantsScreen({super.key});

  @override
  _AddTenantsScreenState createState() => _AddTenantsScreenState();
}

class _AddTenantsScreenState extends State<AddTenantsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRoom;
  String? selectedProperty;
  String gender = 'Male';
  DateTime? dateOfBirth;
  DateTime? moveInDate;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Add Tenants", 
      child:Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdownField(
                              label: "Assign to Room",
                              options: ['1', '2', '3'],
                              selectedValue: selectedRoom,
                              onChanged: (value) =>
                                  setState(() => selectedRoom = value),
                            ),
                            const SizedBox(height: 10),
                            CustomDropdownField(
                              label: "Assign to Property",
                              options: ['1', '2'],
                              selectedValue: selectedProperty,
                              onChanged: (value) =>
                                  setState(() => selectedProperty = value),
                            ),
                            const SizedBox(height: 10),
                            CustomImageUpload(),
                            const SizedBox(height: 10),
                            CustomTextField(
                                label: "Full Name",
                                hintText: "Enter Full Name"),
                            const SizedBox(height: 10),
                            CustomDropdownField(
                              label: "Gender",
                              options: ['Male', 'Female'],
                              selectedValue: gender,
                              onChanged: (value) =>
                                  setState(() => gender = value!),
                            ),
                            const SizedBox(height: 10),
                            CustomDatePicker(
                              label: "Date of Birth",
                              selectedDate: dateOfBirth,
                              onDateSelected: (date) =>
                                  setState(() => dateOfBirth = date),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                                label: "Profession",
                                hintText: "Enter Profession"),
                            const SizedBox(height: 10),
                            CustomDatePicker(
                              label: "Move In Date",
                              selectedDate: moveInDate,
                              onDateSelected: (date) =>
                                  setState(() => moveInDate = date),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                                label: "Address", hintText: "Enter Address"),
                            const SizedBox(height: 10),
                            CustomTextField(
                                label: "Phone Number",
                                hintText: "Enter Phone Number"),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label:
                                  "Telegram Phone Number/Username (Optional)",
                              hintText: "Enter Telegram Contact",
                            ),
                            const SizedBox(height: 20),
                            // Upload ID Label
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ID Card',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                              
                              },
                              child: Container(
                                height: 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.badge, // Replace with your icon
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            // Trash Icon (for removing the uploaded ID)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    8), // Set the radius here
                                child: Container(
                                  color: AppColors.secondaryGrey,
                                  constraints: const BoxConstraints(
                                    minWidth:
                                        10, // Minimum width for the button
                                    minHeight:
                                        10, // Minimum height for the button
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // Handle delete action
                                    },
                                    icon: const Icon(
                                      AppIcons.delete,
                                      color: Colors.black,
                                      size:
                                          20, // Adjust icon size to fit the smaller button
                                    ),
                                    padding: EdgeInsets
                                        .zero, // Remove internal padding for a compact look
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Custombutton(onPressed: () {}, text: "Submit"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ), );
  }
}




