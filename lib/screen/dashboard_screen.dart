import 'package:flutter/material.dart';
import 'package:sankaestay/widgets/Edit_User_Dialog.dart';
import 'package:sankaestay/widgets/Table_Widget.dart';
import '../util/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> users = List.generate(10, (index) {
    return {
      "no": index + 1,
      "id": "ID1234",
      "name": "John Doe",
      "email": "johndoe@example.com",
      "phone": "092716312",
      "role": index % 2 == 0 ? "tenant" : "landlord",
      "createdAt": "27/02/2025 09:34 AM",
      "updatedAt": index == 0 ? "02/03/2025 10:34 AM" : "Null",
      "status": index % 3 == 0 ? "Online" : "Offline",
    };
  });
  void _showEditUserDialog(BuildContext context, Map<String, dynamic> user) {
  showDialog(
    context: context,
    builder: (context) => EditUserDialog(
      user: user,
      onSave: (updatedUser) {
        setState(() {
          user["name"] = updatedUser["name"];
          user["email"] = updatedUser["email"];
          user["phone"] = updatedUser["phone"];
          user["role"] = updatedUser["role"];
        });
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns text to the left
              children: [
                 Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatCard(title: "Total Users", value: "18"),
                    SizedBox(
                      width: 20,
                    ),
                    StatCard(title: "Tenants", value: "14"),
                    SizedBox(
                      width: 20,
                    ),
                    StatCard(title: "Landlords", value: "3"),
                    SizedBox(
                      width: 20,
                    ),
                    StatCard(title: "Active Users", value: "14/18"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // **Centered Table Widget**
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  child: Text(
                    "All Users",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Tablewidget(
              users: users,
              onEditUser: _showEditUserDialog, // Pass function here
            ),
          ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.secondaryBlue, // Dark blue background
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 50),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
