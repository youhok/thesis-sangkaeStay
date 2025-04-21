import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Dropdown_Field.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Date_Picker.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/widgets/Dashed_Line_Painter.dart';

class Generateinvoicescreen extends StatefulWidget {
  const Generateinvoicescreen({super.key});

  @override
  _GenerateinvoicescreenState createState() => _GenerateinvoicescreenState();
}

class _GenerateinvoicescreenState extends State<Generateinvoicescreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedTenant;
  DateTime? payDate = DateTime.now();
  String waterUsage = '';
  String electricityUsage = '';
  String garbage = '';
  String internet = '';
  bool isPaid = false;
  bool isContract = false;
  bool isMonthly = false;

  void _toggleRentType(bool contractSelected) {
    setState(() {
      isContract = contractSelected;
      isMonthly = !contractSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "generate_invoice.title".tr,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Generate Invoice for Tenants',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("generate_invoice.water_rate".tr, style: TextStyle(color: Colors.grey)),
                          Text('0.27 \$/m³')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text("generate_invoice.electricity_rate".tr,
                              style: TextStyle(color: Colors.grey)),
                          Text('0.37 \$/kwh')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text("generate_invoice.garbage_rate".tr, style: TextStyle(color: Colors.grey)),
                          Text('0 \$/month')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text("generate_invoice.internet_rate".tr,
                              style: TextStyle(color: Colors.grey)),
                          Text('0 \$/month')
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: CustomPaint(
                          painter: DashedLinePainter(),
                          child: SizedBox(width: double.infinity, height: 1),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Tenants Dropdown
                      CustomDropdownField(
                        hintText:  "generate_invoice.choose_tenant".tr,
                        label: "generate_invoice.tenants".tr,
                        options: ['Morm Borenn'],
                        selectedValue: selectedTenant,
                        onChanged: (value) =>
                            setState(() => selectedTenant = value),
                      ),
                      const SizedBox(height: 20),

                      // Rent Type Checkbox
                       Text(
                        "generate_invoice.rent_type".tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isContract,
                            activeColor: AppColors.primaryBlue,
                            onChanged: (value) => _toggleRentType(true),
                          ),
                           Text("generate_invoice.contract".tr),
                          const SizedBox(width: 20),
                          Checkbox(
                            value: isMonthly,
                            activeColor: AppColors.primaryBlue,
                            onChanged: (value) => _toggleRentType(false),
                          ),
                           Text("generate_invoice.monthly".tr),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Pay Date Picker
                      CustomDatePicker(
                        label:  "generate_invoice.pay_date".tr,
                        selectedDate: payDate,
                        onDateSelected: (date) =>
                            setState(() => payDate = date),
                      ),
                      const SizedBox(height: 30),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: CustomPaint(
                          painter: DashedLinePainter(),
                          child: SizedBox(width: double.infinity, height: 1),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Utility Input Fields
                      CustomTextField(
                          label: "generate_invoice.water.label".tr,
                          hintText: "generate_invoice.water.placeholder".tr,
                          suffixText: 'm³'),
                      const SizedBox(height: 10),
                      CustomTextField(
                          label: "generate_invoice.electricity.label".tr,
                          hintText: "generate_invoice.electricity.placeholder".tr,
                          suffixText: 'kwh'),
                      const SizedBox(height: 10),
                      CustomTextField(
                          label: "generate_invoice.garbage".tr,
                          hintText: "generate_invoice.garbage".tr,
                          suffixText: '\$'),
                      const SizedBox(height: 10),
                      CustomTextField(
                          label: "generate_invoice.internet".tr,
                          hintText: "generate_invoice.internet".tr,
                          suffixText: '\$'),
                      const SizedBox(height: 20),

                      // Payment Status
                       Text(
                        "generate_invoice.payment_status".tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isPaid,
                            activeColor: AppColors.primaryBlue,
                            onChanged: (value) =>
                                setState(() => isPaid = value!),
                          ),
                           Text("generate_invoice.yes".tr),
                          const SizedBox(width: 20),
                          Checkbox(
                            value: !isPaid,
                            activeColor: AppColors.primaryBlue,
                            onChanged: (value) =>
                                setState(() => isPaid = !value!),
                          ),
                           Text("generate_invoice.no".tr),
                        ],
                      ),
                      const SizedBox(height: 20),

                       Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: CustomPaint(
                          painter: DashedLinePainter(),
                          child: SizedBox(width: double.infinity, height: 1),
                        ),
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text("generate_invoice.total".tr,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('XX.XX \$',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: Custombutton(
                              onPressed: () {},
                              text: "generate_invoice.calculate".tr,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Custombutton(
                              onPressed: () {},
                              text: "generate_invoice.generate".tr,
                            ),
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
