import 'package:flutter/material.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Tenant_Card.dart';
import 'package:sankaestay/util/constants.dart';

class RoomsWithProperty extends StatelessWidget {
  const RoomsWithProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Rooms",
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Property ID: 01",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              TenantCard(roomId: 1),
                              TenantCard(roomId: 2),
                              TenantCard(roomId: 3),
                              TenantCard(roomId: 4),
                              TenantCard(roomId: 5),
                              TenantCard(roomId: 6),
                              TenantCard(roomId: 7),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xFF0A2658),
              child: const Icon(AppIcons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
