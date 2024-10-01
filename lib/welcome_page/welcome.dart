// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_frontend/translate_page/docx_tanslation.dart';
import 'package:gpt_frontend/translate_page/language_translation.dart';
import 'package:gpt_frontend/translate_page/pdf_translation.dart';
import 'package:path/path.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome to RAN AI',
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: Duration(milliseconds: 200),
                ),
              ],
              repeatForever: true,
              pause: Duration(milliseconds: 1000),
            ),
            SizedBox(height: 80),
            Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 380,
                  child: InkWell(
                    onTap: null,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.blue,
                      elevation: 50,
                      //  color: Colors.red,
                      child: Center(
                        child: Text("General chat",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 100,
                  width: 380,
                  child: InkWell(
                    onTap: null,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.orange,
                      elevation: 50,
                      //  color: Colors.red,
                      child: Center(
                        child: Text("Translation",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 100,
                  width: 380,
                  child: InkWell(
                    onTap: null,
                    focusColor: Colors.blue,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      color: Colors.green,
                      elevation: 50,
                      // color: Colors.red,
                      child: Center(
                        child: Text("Coding mode",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
