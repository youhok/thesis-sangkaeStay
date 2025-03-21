import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  final int roomId;

  const BottomSheetContent({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoomHeader(roomId: roomId),
          const SizedBox(height: 10),
          const Text('Assign Tenants'),
          const SizedBox(height: 10),
          const TenantDropdown(),
          const SizedBox(height: 70),
          const SaveButton(),
        ],
      ),
    );
  }
}

class RoomHeader extends StatelessWidget {
  final int roomId;

  const RoomHeader({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Room ID: $roomId',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Handle deletion
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Delete this property?",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class TenantDropdown extends StatelessWidget {
  const TenantDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: const [
        DropdownMenuItem(value: 'Tenant 1', child: Text('Tenant 1')),
        DropdownMenuItem(value: 'Tenant 2', child: Text('Tenant 2')),
        DropdownMenuItem(value: 'Tenant 3', child: Text('Tenant 3')),
      ],
      onChanged: (value) {
        // Handle tenant selection
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Choose tenants',
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Handle save action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF001D57), // Dark blue color
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
