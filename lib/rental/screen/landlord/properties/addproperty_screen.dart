import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sankaestay/core/config/map_picker_screen.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';
import 'package:get/get.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final PageController _pageController = PageController();
  LatLng? _pickedLocation;
  int _currentPage = 0;
  Map<String, bool> roomFeatures = {
    'Bathroom': false,
    'Bed': false,
    'Fan': false,
    'Air Conditioner': false,
    'WiFi': false,
    'Balcony': false,
  };

  void _selectLocation() async {
    LatLng initialLocation =
        const LatLng(11.5564, 104.9282); // Default location (Phnom Penh)

    final LatLng? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPickerScreen(initialLocation: initialLocation),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _pickedLocation = selectedLocation;
      });
    }
  }

  void _goToNextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  // void _goToPreviousPage() {
  //   if (_currentPage > 0) {
  //     _pageController.previousPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "add_property_step_1.title".tr,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
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
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      // First Page
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF0A2658),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                               Text(
                                "add_property_step_1.section_title".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryBlue,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  label: "add_property_step_1.property_name".tr,
                                  hintText: "ពិសិទ្ធបន្ទប់ជួលបឹងឈូក"),
                              const SizedBox(height: 10),
                              CustomTextField(
                                  label: "add_property_step_1.address".tr,
                                  hintText: "ភូមិ, ឃុំ, ស្រុក, ខេត"),
                              const SizedBox(height: 16),

                              // Set on Map
                              Text(
                                'add_property_step_1.set_location'.tr,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: _selectLocation,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _pickedLocation == null
                                          ? 'Set Location'
                                          : 'Lat: ${_pickedLocation!.latitude}, Lng: ${_pickedLocation!.longitude}',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),
                               Text(
                                'add_property_step_1.add_images'.tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: index == 0
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.asset(
                                                  'images/homerental.jpg',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                        AppIcons.image,
                                                        color: Colors.grey);
                                                  },
                                                ),
                                              )
                                            : const Icon(AppIcons.addphoto,
                                                color: Colors.grey),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Description
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'add_property_step_1.description_optional'.tr,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  const SizedBox(height: 8),
                                   TextField(
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: 'add_property_step_1.enter_description'.tr,
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),
                              Custombutton(
                                onPressed: _goToNextPage,
                                text: "add_property_step_1.next".tr,
                              ),
                            
                            ],
                          ),
                        ),
                      ),
                      // Second Page
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF0A2658),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                               Text(
                                "add_property_step_1.section_title".tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryBlue,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children:  [
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'add_property_step_2.room_size'.tr,
                                      hintText: '3×4 m',
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'add_property_step_2.rent_amount'.tr,
                                      hintText: '\$50.0',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                label: 'add_property_step_2.rooms'.tr,
                                hintText: "Enter Quantity's Room",
                              ),
                              const SizedBox(height: 16),
                               Text(
                                'add_property_step_2.room_features'.tr,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: roomFeatures.keys.map((String key) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: roomFeatures[key],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            roomFeatures[key] = value!;
                                          });
                                        },
                                        activeColor: AppColors.primaryBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        side: const BorderSide(
                                            color: Colors.grey, width: 1.5),
                                      ),
                                      Text(
                                        key,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children:  [
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'add_property_step_2.water_price'.tr,
                                      hintText: '\$0.25/m3',
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'add_property_step_2.electricity_price'.tr,
                                      hintText: '\$0.27/kwh',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children:  [
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'add_property_step_2.garbage_price'.tr,
                                      hintText: '\$0.25/month',
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'add_property_step_2.internet_price'.tr,
                                      hintText: '\$1.00/month',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Custombutton(
                                  onPressed: () {}, text: "add_property_step_2.add_property".tr),
                           
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
