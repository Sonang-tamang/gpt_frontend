import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _outputController =
      TextEditingController(); // To display the output
  String _sourceLanguage = 'ne'; // Default to Nepali
  String _targetLanguage = 'en'; // Default to English
  bool _isLoading = false; // To handle loading state

  Future<void> _sendTranslationRequest() async {
    final url =
        Uri.parse('http://192.168.1.87:8000/api/translate/'); // Your local API
    final text = _textController.text;

    if (text.isEmpty) {
      return;
    }

    final body = jsonEncode({
      'text': text,
      'source_language': _sourceLanguage,
      'target_language': _targetLanguage,
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
        // Handle successful response
        final translatedData =
            jsonDecode(response.body); // Assuming the API returns JSON
        _outputController.text = translatedData[
            'translated_text']; // Set the translated text in the output field
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
        title: Text('Text Translation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter text'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Source Language: '),
                DropdownButton<String>(
                  value: _sourceLanguage,
                  items: [
                    DropdownMenuItem(value: 'ne', child: Text('Nepali')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    // Add more languages as needed
                  ],
                  onChanged: (value) {
                    setState(() {
                      _sourceLanguage = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Target Language: '),
                DropdownButton<String>(
                  value: _targetLanguage,
                  items: [
                    DropdownMenuItem(value: 'ne', child: Text('Nepali')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    // Add more languages as needed
                  ],
                  onChanged: (value) {
                    setState(() {
                      _targetLanguage = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendTranslationRequest,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Translate'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _outputController, // Output text field
              decoration: InputDecoration(labelText: 'Translation Output'),
              maxLines: 5,
              readOnly: true, // Make it read-only
            ),
          ],
        ),
      ),
    );
  }
}
