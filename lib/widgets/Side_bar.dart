import 'package:flutter/material.dart';
import 'package:sankaestay/util/constants.dart';
import 'package:sankaestay/widgets/Triangle_Painter.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onItemSelected;

  const Sidebar({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, // Fixed width to prevent resizing
      child: Drawer(
        child: Container(
          color: AppColors.primaryBlue,
          child: Column(
            children: [
              // Logo and Title
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "images/10.png",
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "SangkaeStay",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Menu Items
              Expanded(
                child: Column(
                  children: [
                    DrawerItem(
                      icon: Icons.dashboard,
                      text: "Dashboard",
                      onTap: () => onItemSelected(0),
                      isSelected: true,
                    ),
                    DrawerItem(
                      icon: Icons.people,
                      text: "Users",
                      onTap: () => onItemSelected(1),
                    ),
                    DrawerItem(
                      icon: Icons.notifications,
                      text: "Push Notification",
                      onTap: () => onItemSelected(2),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 150, // Set a fixed width
                        height: 300, // Set a fixed height
                        child: CustomPaint(
                          painter: TrianglePainter(direction: TriangleDirection.right),
                        ),
                      ),
                    ),
                    DrawerItem(
                      icon: Icons.logout,
                      text: "LogOut",
                      onTap: () {
                        // Handle logout action here
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final Function() onTap;

  const DrawerItem({super.key, 
    required this.icon,
    required this.text,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures the width is always consistent
      color: isSelected ? Colors.indigo[700] : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        onTap: onTap,
      ),
    );
  }
}
