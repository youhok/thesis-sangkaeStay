import 'package:flutter/material.dart';
import 'package:sankaestay/util/constants.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final String? suffixText;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final bool isMultiline;
  final Function(String)? onChanged;

  const CustomTextField({
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.suffixText,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.isMultiline = false,
    this.onChanged,
    super.key,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          maxLines: widget.isMultiline ? null : 1,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
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
            suffixText: widget.suffixText,
            suffixStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon != null
                    ? Icon(widget.suffixIcon, color: Colors.grey)
                    : null,
          ),
        ),
      ],
    );
  }
}