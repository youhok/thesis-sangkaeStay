import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/custom_search_field.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/rental/widgets/landlordwidgets/Tenant_Card.dart';



class RoomsWithoutPropertyid extends StatefulWidget {
  const RoomsWithoutPropertyid({super.key});

  @override
  _RoomsWithoutPropertyidState createState() =>
      _RoomsWithoutPropertyidState();
}

class _RoomsWithoutPropertyidState extends State<RoomsWithoutPropertyid> {
  String? selectedTenant;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "property_detail.rooms".tr,
       child:Stack(
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
                          Container(
                             margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: CustomSearchField()
                          ),
                          const SizedBox(height: 10),
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


