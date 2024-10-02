// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_frontend/components/switch_button.dart'; // Assuming you have a switch button component
import 'package:http/http.dart' as http;
import 'dart:convert';

class LanguageTranslation extends StatefulWidget {
  const LanguageTranslation({super.key});

  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _outputController =
      TextEditingController(); // For translation output
  bool _isLoading = false;
  bool isEnglish = true;

  Future<void> _sendTranslationRequest() async {
    final url = Uri.parse('http://192.168.17.111:8000/api/translate/');
    final userInputText = _textController.text;

    if (userInputText.isEmpty) {
      return;
    }

    // JSON
    final body = jsonEncode({
      'text': userInputText,
      'source_language': isEnglish ? 'en' : 'ne',
      'target_language': isEnglish ? 'ne' : 'en',
    });

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final translatedData = jsonDecode(response.body);
        _outputController.text = translatedData['translated_text'];
      } else {
        _outputController.text =
            'Translation failed. Status code: ${response.statusCode}';
      }
    } catch (error) {
      _outputController.text = 'Error occurred: $error';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          "R A N Translate",
          style: TextStyle(
            fontSize: 24,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Container(
                height: 200,
                padding: EdgeInsets.all(30),
                child: TextField(
                  controller: _textController,
                  expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    hintText: "Enter Text......",
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _sendTranslationRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 47, 48, 48),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: const Color.fromARGB(255, 255, 255, 255))
                  : Text(
                      'Translate',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                    ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(30),
                  child: TextField(
                    controller: _outputController,
                    expands: true,
                    maxLines: null, // Set maxLines to null
                    minLines: null,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                      filled: true,
                      hintText: "Translated Text....",
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ),
            SwitchButton(
              onLanguageChanged: (isEnglishSelected) {
                setState(() {
                  isEnglish = isEnglishSelected;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
