import 'package:flutter/material.dart';
import 'package:sankaestay/util/constants.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? hintText;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropdownField({
    required this.label,
    required this.options,
    this.hintText,
    this.selectedValue,
    required this.onChanged,
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
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.white,
          value: selectedValue,
          items: [
            if (hintText != null && selectedValue == null)
              DropdownMenuItem<String>(
                value: null,
                child: Text(
                  hintText ?? '',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ...options
                .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText, // Added hintText here
            hintStyle: const TextStyle(color: Colors.grey), // Styled hint text
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.secondaryBlue,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
