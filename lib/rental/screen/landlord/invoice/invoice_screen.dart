import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Dropdown_Field.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Custom_Date_Picker.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Custom_Text_Field.dart';
import 'package:sankaestay/rental/widgets/Custom_button.dart';
import 'package:sankaestay/widgets/Dashed_Line_Painter.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
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
      title: "Generate Invoice", 
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Water', style: TextStyle(color: Colors.grey)),
                    Text('0.27 \$/m³')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Electricity', style: TextStyle(color: Colors.grey)),
                    Text('0.37 \$/kwh')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Garbage', style: TextStyle(color: Colors.grey)),
                    Text('0 \$/month')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Internet', style: TextStyle(color: Colors.grey)),
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
                  hintText: 'Choose Tenants',
                  label: 'Tenants',
                  options: ['Morm Borenn'],
                  selectedValue: selectedTenant,
                  onChanged: (value) => setState(() => selectedTenant = value),
                ),
                const SizedBox(height: 20),

                // Rent Type Checkbox
                const Text(
                  'Rent Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isContract,
                      activeColor: AppColors.primaryBlue,
                      onChanged: (value) => _toggleRentType(true),
                    ),
                    const Text('Contract'),
                    const SizedBox(width: 20),
                    Checkbox(
                      value: isMonthly,
                      activeColor: AppColors.primaryBlue,
                      onChanged: (value) => _toggleRentType(false),
                    ),
                    const Text('Monthly'),
                  ],
                ),
                const SizedBox(height: 10),

                // Pay Date Picker
                CustomDatePicker(
                  label: 'Pay Date',
                  selectedDate: payDate,
                  onDateSelected: (date) => setState(() => payDate = date),
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
                    label: 'Water Usage',
                    hintText: 'Enter water usage',
                    suffixText: 'm³'),
                const SizedBox(height: 10),
                CustomTextField(
                    label: 'Electricity Usage',
                    hintText: 'Enter electricity usage',
                    suffixText: 'kwh'),
                const SizedBox(height: 10),
                CustomTextField(
                    label: 'Garbage', hintText: 'Enter garbage fee', suffixText: '\$'),
                const SizedBox(height: 10),
                CustomTextField(
                    label: 'Internet', hintText: 'Enter internet fee', suffixText: '\$'),
                const SizedBox(height: 20),

                // Payment Status
                const Text(
                  'Payment Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isPaid,
                      activeColor: AppColors.primaryBlue,
                      onChanged: (value) => setState(() => isPaid = value!),
                    ),
                    const Text('Yes'),
                    const SizedBox(width: 20),
                    Checkbox(
                      value: !isPaid,
                      activeColor: AppColors.primaryBlue,
                      onChanged: (value) => setState(() => isPaid = !value!),
                    ),
                    const Text('No'),
                  ],
                ),
                const SizedBox(height: 20),

                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('XX.XX \$',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: Custombutton(
                        onPressed: () {},
                        text: 'Calculate',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Custombutton(
                        onPressed: () {},
                        text: 'Generate',
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
      )
      );
  }
}


