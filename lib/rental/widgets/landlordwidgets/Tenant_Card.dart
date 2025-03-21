import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Bottom_Sheet_Content.dart';
import 'package:sankaestay/util/constants.dart'; // Adjust the import path for your BottomSheetContent widget

class TenantCard extends StatelessWidget {
  final int roomId;

  const TenantCard({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (BuildContext context) {
            return BottomSheetContent(roomId: roomId);
          },
        );
      },
      child: Card(
        elevation: 0,
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  roomId.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            title: const Text(
              'No Tenants',
              style: TextStyle(
                color: AppColors.secondaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              "Tenant's Phone number",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
