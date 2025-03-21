import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/dynamicscreen/base_screen.dart';
import 'package:sankaestay/util/constants.dart';

class LanguageLandlord extends StatefulWidget {
  const LanguageLandlord({super.key});

  @override
  State<LanguageLandlord> createState() => _LanguageLandlordState();
}

class _LanguageLandlordState extends State<LanguageLandlord> {
    String selectedLanguage = "English";

  final List<Map<String, String>> languages = [
    {"name": "Khmer", "flag": "images/cambodiaflag.png"},
    {"name": "English", "flag": "images/united-states.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Language", 
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.secondaryGrey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Select Language of your desire",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ListView(
                            children: languages.map((language) {
                              bool isSelected =
                                  language["name"] == selectedLanguage;
                              return MouseRegion(
                                onEnter: (_) {
                                  setState(() {
                                    selectedLanguage = language["name"]!;
                                  });
                                },
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedLanguage = language["name"]!;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primaryBlue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            )
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                language["flag"]!,
                                                width: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                language["name"]!,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                          if (isSelected)
                                            const Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            )
                                        ],
                                      ),
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      );
  }
}


