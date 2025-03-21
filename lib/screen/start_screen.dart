import 'package:flutter/material.dart';
import 'package:sankaestay/screen/dashboard_screen.dart';
import 'package:sankaestay/screen/push_notification.dart';
import 'package:sankaestay/screen/user_screen.dart';
import 'package:sankaestay/widgets/Side_bar.dart';
import 'package:sankaestay/widgets/nav_bar.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    UserScreen(),
    PushNotification(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer after selecting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      drawer: Sidebar(onItemSelected: _onItemSelected), // Pass function here
      body: _pages[_selectedIndex], // Display selected page
    );
  }
}
