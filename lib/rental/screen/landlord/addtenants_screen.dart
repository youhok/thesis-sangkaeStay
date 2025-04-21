import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
// import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Date_Picker.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Dropdown_Field.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Image_Upload.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';

class AddTenantsScreen extends StatefulWidget {
  @override
  State<AddTenantsScreen> createState() => _AddTenantsScreenState();
}

class _AddTenantsScreenState extends State<AddTenantsScreen> {
  final _formKey = GlobalKey<FormState>();

  var selectedRoom = Rx<String?>('1');
  var selectedProperty = Rx<String?>('1');
  var gender = Rx<String>('male');
  var dateOfBirth = Rx<DateTime?>(null);
  var moveInDate = Rx<DateTime?>(null);
  File? profileImage;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "add_tenant.add_tenant".tr,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
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
                            Obx(() {
                              return CustomDropdownField(
                                label: "add_tenant.assign_to_room".tr,
                                options: ['1', '2', '3'],
                                selectedValue: selectedRoom.value,
                                onChanged: (value) =>
                                    selectedRoom.value = value,
                              );
                            }),
                            const SizedBox(height: 10),
                            Obx(() {
                              return CustomDropdownField(
                                label: "add_tenant.assign_to_property".tr,
                                options: ['1', '2'],
                                selectedValue: selectedProperty.value,
                                onChanged: (value) =>
                                    selectedProperty.value = value,
                              );
                            }),
                            const SizedBox(height: 10),
                            CustomImageUpload(
                              imageFile: profileImage,
                              onImageChanged: (newImage) {
                                profileImage = newImage;
                              },
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "add_tenant.full_name".tr,
                              hintText: "add_tenant.placeholders.enter_full_name".tr,
                            ),
                            const SizedBox(height: 10),
                            Obx(() {
                              return CustomDropdownField(
                                label: "add_tenant.gender".tr,
                                options: ["male", "female"],
                                selectedValue: gender.value,
                                onChanged: (value) => gender.value = value!,
                                itemLabelBuilder: (value) =>
                                    "add_tenant.labels.$value".tr,
                              );
                            }),
                            const SizedBox(height: 10),
                            CustomDatePicker(
                              label: "add_tenant.date_of_birth".tr,
                              selectedDate: dateOfBirth.value,
                              onDateSelected: (date) =>
                                  dateOfBirth.value = date,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "add_tenant.profession".tr,
                              hintText: "add_tenant.placeholders.enter_profession".tr,
                            ),
                            const SizedBox(height: 10),
                            CustomDatePicker(
                              label: "add_tenant.move_in_date".tr,
                              selectedDate: moveInDate.value,
                              onDateSelected: (date) =>
                                  moveInDate.value = date,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "add_tenant.address".tr,
                              hintText: "add_tenant.placeholders.enter_address".tr,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "add_tenant.phone_number".tr,
                              hintText: "add_tenant.placeholders.enter_phone_number".tr,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "add_tenant.telegram_phone_number".tr,
                              hintText:
                                  "add_tenant.placeholders.enter_telegram_contact".tr,
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "add_tenant.id_card".tr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // logic to upload ID card
                              },
                              child: Container(
                                height: 220,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.badge,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Custombutton(
                              onPressed: () {
                                // handle form submission
                              },
                              text: "add_tenant.submit".tr,
                            ),
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
      ),
    );
  }
}
