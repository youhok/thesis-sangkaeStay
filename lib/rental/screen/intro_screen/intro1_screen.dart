import 'package:flutter/material.dart';

import 'package:sankaestay/util/constants.dart';

class Intro1Screen extends StatelessWidget {
  const Intro1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue, // Dark blue background
      body: Column(
        children: [
          // Top Blue Section
          Container(
            height: MediaQuery.of(context).size.height * 0.1, // Top section height
            width: double.infinity,
            color: Color(0xFF001D57), // Dark blue color
          ),
          // Content Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Illustration
                        SizedBox(height: 70,),
                        Image.asset(
                          'images/House searching-rafiki.png', // Replace with your image asset path
                          height: 250, // Adjust size as needed
                        ),
                        SizedBox(height: 30),
                        // Title
                        Text(
                          'Find Your Property',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        // Subtitle
                        Text(
                          'Explore a wide range of properties tailored to your needs, from cozy apartments to spacious homes.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // Button Section
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the next screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF001D57), // Dark blue color
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
