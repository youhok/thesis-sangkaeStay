import 'package:flutter/material.dart';

import 'package:sankaestay/util/constants.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CustomDatePicker({
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryBlue, // Apply primary blue color
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: selectedDate != null
                ? "${selectedDate!.toLocal()}".split(' ')[0]
                : "Select date",
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue, // Set border color to primary blue
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue, // Highlight border color
                width: 2.0,
              ),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today, color: AppColors.primaryBlue), // Change icon color
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: AppColors.primaryBlue, // Change date picker theme color
                          onPrimary: Colors.white, // Change selected text color
                          onSurface: AppColors.primaryBlue, // Change default text color
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  onDateSelected(pickedDate);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
