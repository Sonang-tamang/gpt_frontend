// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final ValueChanged<bool>
      onLanguageChanged; // Callback to update the language state in parent

  const SwitchButton({Key? key, required this.onLanguageChanged})
      : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isEnglish = true; // Initial language state

  // Function to switch between English and Nepali
  void switchLanguage() {
    setState(() {
      isEnglish = !isEnglish; // Toggle language
    });
    widget.onLanguageChanged(isEnglish); // Notify parent of the language change
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: isEnglish
          ? [
              // English Button on the left
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isEnglish ? Colors.white : Colors.grey[850],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Swap Icon
              IconButton(
                icon: Icon(Icons.swap_horiz,
                    color: const Color.fromARGB(255, 41, 41, 41), size: 30),
                onPressed: switchLanguage, // Switches language when pressed
              ),
              SizedBox(width: 10),
              // Nepali Button on the right
              ElevatedButton(
                onPressed: switchLanguage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Nepali',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ]
          : [
              // Nepali Button on the left (switched position)
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Nepali',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 10),
              // Swap Icon
              IconButton(
                icon: Icon(Icons.swap_horiz,
                    color: const Color.fromARGB(255, 41, 41, 41), size: 30),
                onPressed: switchLanguage, // Switches language when pressed
              ),
              SizedBox(width: 10),
              // English Button on the right (switched position)
              ElevatedButton(
                onPressed: switchLanguage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: !isEnglish ? Colors.grey[850] : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
    );
  }
}
