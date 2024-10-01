// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class DocxTanslation extends StatefulWidget {
  const DocxTanslation({super.key});

  @override
  State<DocxTanslation> createState() => _DocxTanslationState();
}

class _DocxTanslationState extends State<DocxTanslation> {
  //list for storing the files################################################
  List pickedFiles = [];

  pickFiles() async {
    var result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['docx']);

    print(result);
    if (result != null) {
      setState(() {
        pickedFiles = result.files.map((file) => File(file.path!)).toList();
      });
    }
  }

  openFile(file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Docx Translate",
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Text(
                      "Translate you files",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                height: 100,
                width: 300,
                child: InkWell(
                  onTap: pickFiles,
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
                          onTap: () => openFile(pickedFiles[index]),
                          child: SizedBox(
                            height: 60, // Set the desired height

                            child: Card(
                              color: const Color.fromARGB(255, 57, 49, 49),
                              child: ListTile(
                                leading: returnLogo(pickedFiles[index]),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "File: ${basename(pickedFiles[index].path)}",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: InkWell(
                  onTap: null,
                  child: Card(
                    color: const Color.fromARGB(255, 80, 74, 74),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Translate",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 20),
                        ),
                        Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
                    )),
                  ),
                ),
              ),
              // Icon(Icons.swap_vert,color: Colors.black,size: 40,),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                  height: 80,
                  width: 270,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Download",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 30),
                          ),
                          Icon(
                            Icons.download, // Download icon
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 160,
                width: 350,
                child: Card(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}

returnLogo(file) {
  var ex = extension(file.path);

  if (ex == ".docx") {
    return Icon(
      Icons.insert_drive_file,
      color: const Color.fromARGB(255, 255, 255, 255),
    );
  } else {
    return Icon(
      Icons.question_mark_outlined,
      color: Colors.black,
    );
  }
}
