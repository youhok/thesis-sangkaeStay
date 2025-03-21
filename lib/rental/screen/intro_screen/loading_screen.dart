import 'package:flutter/material.dart';
import 'package:sankaestay/util/constants.dart';

import 'package:sankaestay/widgets/Triangle_Painter.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue, // Dark blue background color
      body: SafeArea(
        child: Stack(
          children: [
            // Top triangle
            Align(
              alignment: Alignment.topLeft,
              child: CustomPaint(
                size: Size(170, 330),
                painter: TrianglePainter(direction: TriangleDirection.right),
              ),
            ),
            // Bottom triangle
            Align(
              alignment: Alignment.bottomRight,
              child: CustomPaint(
                size: Size(150, 230),
                painter: TrianglePainter(direction: TriangleDirection.left),
              ),
            ),
            // Center content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo (replace with your logo asset if you have one)
                  Container(
                    width: 170,
                    height: 170,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.asset(
                          "images/sangkaestay.ico"), // Replace with your asset path
                    ),
                  ),
                  const SizedBox(height: 16),
                  // App name
                  const Text(
                    'SangkaeStay',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  const Text(
                    'Find Room & Manage Property',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

