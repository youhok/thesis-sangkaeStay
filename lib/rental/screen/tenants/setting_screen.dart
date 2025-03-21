import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/Outlined_Button.dart';
import 'package:sankaestay/rental/widgets/profile_menu_Item.dart';
import 'package:sankaestay/rental/widgets/profile_user.dart';
import 'package:sankaestay/util/constants.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            // Profile Card
                           ProfileUser(imagePath: 'images/person.png', name: "Heng Youhok"),

                            const SizedBox(height: 20),
                            ProfileMenuItem(
                              icon: Icons.edit,
                              text: 'Edit Profile',
                              onTap: () {},
                            ),
                            ProfileMenuItem(
                              icon: Icons.language,
                              text: 'Language',
                              onTap: () {},
                            ),
                            ProfileMenuItem(
                              icon: Icons.support_agent,
                              text: 'Support',
                              onTap: () {},
                            ),
                            SizedBox(
                              height: 280,
                            ),

                            CustomOutlinedButton(
                              text: "Log Out",
                              onPressed: () {
                                // Your logout logic here
                              },
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
