import 'package:flutter/material.dart';

class IDCardUploadWidget extends StatelessWidget {
  final VoidCallback onUpload;

  const IDCardUploadWidget({super.key, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload ID Card',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onUpload,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.cloud_upload, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
