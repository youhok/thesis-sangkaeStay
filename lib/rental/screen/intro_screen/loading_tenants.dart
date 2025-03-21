import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sankaestay/util/constants.dart';


class LoadingTenants extends StatelessWidget {
  const LoadingTenants({super.key});

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
                        SvgPicture.asset("images/logo_blue.svg", height: 130, width: 130,),
                        SizedBox(height: 30),
                        // Title
                        Text(
                          "Let's Go",
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
                          'We will redirect to home page in  a minutes',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset("images/undraw_connecting-teams_nnjy.png")
                      ],
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