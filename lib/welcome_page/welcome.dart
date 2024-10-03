// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_frontend/chat_page/genral_chat_page.dart';
import 'package:gpt_frontend/translate_page/docx_tanslation.dart';
import 'package:gpt_frontend/translate_page/language_translation.dart';
import 'package:gpt_frontend/translate_page/pdf_translation.dart';
import 'package:gpt_frontend/translate_page/test.dart';
import 'package:gpt_frontend/translate_page/translate_home.dart';

import 'package:path/path.dart' as path;

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Welcome Page',
      //     style: TextStyle(fontSize: 30),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   height: 100,
            //   width: 100,
            //   child: Image.asset(
            //     "images/ai.png",
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome to RAN AI',
                  textStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Colors.red),
                  speed: Duration(milliseconds: 200),
                ),
              ],
              repeatForever: true,
              pause: Duration(milliseconds: 1000),
            ),
            SizedBox(height: 180),
            Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 380,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      goto_Chat(context); // Correct call passing BuildContext
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Colors.blue,
                      elevation: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("General chat",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                                textAlign: TextAlign.center),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.chat,
                              size: 40,
                            )
                          ],
                        ),
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
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      goto_Translation(context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Colors.orange,
                      elevation: 50,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Translation",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                                textAlign: TextAlign.center),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.translate,
                              size: 40,
                            )
                          ],
                        ),
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
                    borderRadius: BorderRadius.circular(40),
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text("Kam hudai xa !!!"),
                      //     duration: Duration(seconds: 3),
                      //   ),
                      // );
                      goto_Coding(context);
                    },
                    focusColor: Colors.blue,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      color: Colors.green,
                      elevation: 20,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Coding mode",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                                textAlign: TextAlign.center),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.computer,
                              size: 40,
                            )
                          ],
                        ),
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

  // No changes here, the method is correct
  void goto_Chat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GenralChatPage()),
    );
  }

  void goto_Translation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TranslateHome()),
    );
  }

  void goto_Coding(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DocxTranslation2()),
    );
  }
}
