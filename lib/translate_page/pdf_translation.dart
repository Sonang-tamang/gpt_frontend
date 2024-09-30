// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

class PdfTranslation extends StatefulWidget {
  const PdfTranslation({super.key});

  @override
  State<PdfTranslation> createState() => _PdfTranslationState();
}

class _PdfTranslationState extends State<PdfTranslation> {
  //list for storing the files################################################
  List pickedFiles = [];

  pickFiles() async {
    var result = await FilePicker.platform
        .pickFiles(allowMultiple: true, allowedExtensions: ['pdf']);

    print(result);
    if (result != null) {
      setState(() {});
    }
  }

  openfile(file) {
    OpenFile.open(file.Path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "PDF Translate",
            style: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              SizedBox(
                height: 120,
                width: 320,
                child: InkWell(
                  onTap: null,
                  child: Card(
                    elevation: 50,
                    color: const Color.fromARGB(255, 80, 74, 74),
                    child: Center(
                      child: Text(
                        "Select File",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              pickedFiles.isNotEmpty
                  ? ListView.builder(
                      itemCount: pickedFiles.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => openfile(pickedFiles[index]),
                          child: Card(
                            child: ListTile(
                              subtitle: Text(
                                "File: ${pickedFiles[index].path}",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
            ],
          ),
        ));
  }
}

// returnLogo(File) {
//   var ex = extension()
// }
