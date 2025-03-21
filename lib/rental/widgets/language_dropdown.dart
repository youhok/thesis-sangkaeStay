import 'package:flutter/material.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = 'EN';

  final Map<String, String> languages = {
    'EN': 'images/united-states.png', // Change to PNG or JPG as needed
    'KH': 'images/cambodiaflag.png',
  };

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.white, // Sets dropdown background to white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: (String value) {
          setState(() {
            selectedLanguage = value;
          });
        },
        itemBuilder: (BuildContext context) {
          return languages.keys.map((String language) {
            return PopupMenuItem<String>(
              value: language,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(language, style: const TextStyle(fontSize: 16)),
                  SizedBox(
                    width: 30,
                    child: Image.asset(languages[language]!),
                  ),
                ],
              ),
            );
          }).toList();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF001D57),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedLanguage,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 30,
                child: Image.asset(languages[selectedLanguage]!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
