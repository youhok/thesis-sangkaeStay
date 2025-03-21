import 'package:flutter/material.dart';
import 'package:sankaestay/util/constants.dart';


class CustomImageUpload extends StatelessWidget {
  const CustomImageUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tenant Profile (Optional)",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8), // Set the radius here
                child: Container(
                  color: AppColors.secondaryGrey,
                  constraints: const BoxConstraints(
                    minWidth: 10, // Minimum width for the button
                    minHeight: 10, // Minimum height for the button
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Handle delete action
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                      size: 20, // Adjust icon size to fit the smaller button
                    ),
                    padding: EdgeInsets
                        .zero, // Remove internal padding for a compact look
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
