// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_frontend/chat_page/genral_chat_page.dart';
import 'package:gpt_frontend/translate_page/docx_tanslation.dart';
import 'package:gpt_frontend/translate_page/language_translation.dart';
import 'package:gpt_frontend/translate_page/pdf_translation.dart';
import 'package:gpt_frontend/translate_page/test.dart';

class TranslateHome extends StatefulWidget {
  const TranslateHome({super.key});

  @override
  State<TranslateHome> createState() => _TranslateHomeState();
}

class _TranslateHomeState extends State<TranslateHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 208, 212),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          "T R A N S L A T E",
          style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 24),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(
            height: 90,
          ),
          Center(
            child: Text("Welcome to Translation ",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    fontFamily: GoogleFonts.poppins().fontFamily),
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: 140,
          ),
          SizedBox(
            height: 120,
            width: 380,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: go,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 50,
                color: const Color.fromARGB(255, 102, 97, 97),
                child: Center(
                  child: Text("Language Translation",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
            width: 380,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: go2,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 50,
                color: Colors.red,
                child: Center(
                  child: Text("PDF Translation",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
            width: 380,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: go3,
              // focusColor: Colors.blue,
              child: Card(
                color: Colors.brown,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 50,
                child: Center(
                  child: Text("DOCX Translation",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.white),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void go() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LanguageTranslation()));
  }

  void go2() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PdfTranslation()));
  }

  void go3() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DocxTanslation()));
  }
}
