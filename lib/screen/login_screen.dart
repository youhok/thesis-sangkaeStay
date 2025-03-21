import 'package:flutter/material.dart';

import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Triangle_Painter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 bool _obscurePassword = true;
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
              child: SingleChildScrollView(
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
                            "images/10.png"), // Replace with your asset path
                      ),
                    ),
                            
                const SizedBox(height: 16),
                // Welcome text
                const Text(
                  'Welcome Admin!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                // Username field
                SizedBox(
                  width: 380,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Username',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 380,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Enter Username',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Password field
                SizedBox(
                  width: 380,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 380,
                  child: TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Enter Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Login button
                SizedBox(
                  width: 380,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Login'),
                  ),
                ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
