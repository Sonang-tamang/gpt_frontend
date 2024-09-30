import 'package:flutter/material.dart';
import 'package:gpt_frontend/chat_page/genral_chat_page.dart';
import 'package:gpt_frontend/themes/light_mode.dart';
import 'package:gpt_frontend/translate_page/translate_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TranslateHome(),
      theme: lightMode,
    );
  }
}
