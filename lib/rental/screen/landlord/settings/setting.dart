import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/Outlined_Button.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/profile_menu_Item.dart';
import 'package:sankaestay/rental/widgets/profile_user.dart';
import 'package:sankaestay/util/constants.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Settings", 
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGrey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0), // Add padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        ProfileUser(
                            imagePath: 'images/person.png',
                            name: "Heng Youhok"),
                            
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
                        Spacer(),
                        CustomOutlinedButton(
                          text: "Log Out",
                          onPressed: () {
                            // Your logout logic here
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      );
  }
}


