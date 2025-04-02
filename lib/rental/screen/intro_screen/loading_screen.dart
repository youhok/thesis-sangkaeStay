import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/auth/role/role_screen.dart';
import 'package:sankaestay/widgets/Triangle_Painter.dart';
import 'package:sankaestay/rental/widgets/tenentwidgets/Bottom_navbar.dart';
import 'package:sankaestay/rental/screen/landlord/dash_board.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Show loading screen for 2 seconds
    if (!mounted) return;

    final user = _auth.currentUser;
    if (user == null) {
      // User is not authenticated, navigate to role screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RoleScreen()),
      );
    } else {
      try {
        // Get user document from Firestore
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          // If user document doesn't exist, navigate to role screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RoleScreen()),
          );
          return;
        }

        final userData = userDoc.data();
        final role = userData?['role'] as String?;

        if (role == null) {
          // If role is not set, navigate to role screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RoleScreen()),
          );
          return;
        }

        // Navigate based on role
        if (role == 'tenant') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavBar()),
          );
        } else if (role == 'landlord') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          // Unknown role, navigate to role screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RoleScreen()),
          );
        }
      } catch (e) {
        print('Error checking user role: $e');
        // On error, navigate to role screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RoleScreen()),
        );
      }
    }
  }

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
                      fontSize: 14,
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
