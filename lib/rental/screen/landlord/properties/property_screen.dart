import 'package:flutter/material.dart';
import 'package:sankaestay/rental/screen/landlord/properties/addproperty_screen.dart';
import 'package:sankaestay/rental/util/icon_util.dart';
import 'package:sankaestay/rental/widgets/custom_search_field.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/util/constants.dart';

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key});

  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> properties = [
    {
      "title": "Room Rental Battambang",
      "address": "#110, Group 04, Commune, City",
      "id": "BTB1241",
      "rooms": 10,
      "tenants": 0,
      "price": 50.0,
      "image": "assets/sample_property.jpg"
    },
    {
      "title": "Apartment Phnom Penh",
      "address": "St 200, Phnom Penh",
      "id": "PP4562",
      "rooms": 15,
      "tenants": 5,
      "price": 120.0,
      "image": "assets/sample_property2.jpg"
    },
  ];

  List<Map<String, dynamic>> filteredProperties = [];

  @override
  void initState() {
    super.initState();
    filteredProperties = properties; // Initially show all properties
  }

  void _filterProperties(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProperties = properties;
      } else {
        filteredProperties = properties
            .where((property) =>
                property['title'].toLowerCase().contains(query.toLowerCase()) ||
                property['address'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Properties",
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
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0 , right: 12.0),
                        child: CustomSearchField(
                          controller: _searchController,
                          onChanged: _filterProperties,
                          hintText: 'Search properties...',
                        ),
                      ),
                      const SizedBox(height: 10),
                      filteredProperties.isEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 200),
                              child: Center(
                                child: Image.asset(
                                  "images/undraw_no-data_ig65-removebg-preview.png",
                                  height: 250,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      "Image not found",
                                      style: TextStyle(color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: filteredProperties.length,
                                itemBuilder: (context, index) {
                                  final property = filteredProperties[index];
                                  return RoomRentalCard(property: property);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPropertyScreen(),
                  ),
                );
              },
              backgroundColor: AppColors.primaryBlue,
              child: const Icon(AppIcons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    )
     ;
  }
}

class RoomRentalCard extends StatelessWidget {
  final Map<String, dynamic> property;

  const RoomRentalCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  property['image'],
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            property['title'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            '\$${property['price']}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      property['address'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Property ID: ${property['id']}',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700])),
                        Text('Room: ${property['rooms']}',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700])),
                        Text('Tenants: ${property['tenants']}',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700])),
                      ],
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
