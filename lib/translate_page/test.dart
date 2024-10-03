// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_frontend/components/switch_button.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DocxTranslation2 extends StatefulWidget {
  const DocxTranslation2({super.key});

  @override
  State<DocxTranslation2> createState() => _DocxTranslationState();
}

class _DocxTranslationState extends State<DocxTranslation2> {
  List<File> pickedFiles = [];
  List<File> translatedFiles = [];

  bool _isLoading = false;
  String _loadingMessage = "";
  bool isEnglish = true;

  // Method to pick files
  Future<void> pickFiles() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['docx'],
    );

    if (result != null) {
      setState(() {
        pickedFiles = result.files.map((file) => File(file.path!)).toList();
      });
    }
  }

  // Open a file
  Future<void> openFile(File file) async {
    var result = await OpenFile.open(file.path);
    print(result.message);
  }

  // Method to translate files
  Future<void> translateFiles() async {
    if (pickedFiles.isEmpty) return;

    setState(() {
      _isLoading = true;
      _loadingMessage = "Translating..."; // Initially show "Sending..."
    });

    try {
      for (var file in pickedFiles) {
        print('Sending file: ${file.path}');

        var url = Uri.parse("http://192.168.17.111:8000/api/translate_docx/");
        var request = http.MultipartRequest('POST', url);

        request.files.add(await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('application',
              'vnd.openxmlformats-officedocument.wordprocessingml.document'),
        ));

        request.fields['source_language'] = isEnglish ? 'en' : 'ne';
        request.fields['target_language'] = isEnglish ? 'ne' : 'en';

//for debuging###################################################################################
        print(
            'Requesting translation from ${isEnglish ? 'English' : 'Nepali'} to ${isEnglish ? 'Nepali' : 'English'}');

// onLanguageChanged: (isEnglishSelected) {
//   print("Language switched: ${isEnglishSelected ? 'English' : 'Nepali'}");
//   setState(() {
//     isEnglish = isEnglishSelected;
//   });
// },

        var response = await request.send();

        if (response.statusCode == 200) {
          setState(() {
            _loadingMessage = "File sent, Translating...";
          });

          var responseData = await http.Response.fromStream(response);

          Directory tempDir = await getTemporaryDirectory();
          String filePath =
              '${tempDir.path}/translated_${p.basename(file.path)}';
          File translatedFile = File(filePath);

          await translatedFile.writeAsBytes(responseData.bodyBytes);

          setState(() {
            translatedFiles.add(translatedFile);
          });
        } else {
          print(
              'Failed to translate file. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error while translating files: $e');
      setState(() {
        _loadingMessage =
            'Error while translating file. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to download the translated file
  Future<void> downloadTranslatedFile(File translatedFile) async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        Directory? downloadsDir = Directory('/storage/emulated/0/Download');
        if (!downloadsDir.existsSync()) {
          downloadsDir.createSync();
        }

        String newFilePath =
            '${downloadsDir.path}/translated_${p.basename(translatedFile.path)}';
        File newFile = File(newFilePath);
        await newFile.writeAsBytes(await translatedFile.readAsBytes());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('File downloaded to Downloads folder'),
        ));
      } catch (e) {
        print('Error saving file: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error downloading file: $e'),
        ));
      }
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Storage permission denied'),
      ));
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
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
                  "Translate your files",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
            SizedBox(height: 20),
            pickedFiles.isNotEmpty
                ? ListView.builder(
                    itemCount: pickedFiles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => openFile(pickedFiles[index]),
                        child: SizedBox(
                          height: 60,
                          child: Card(
                            color: const Color.fromARGB(255, 57, 49, 49),
                            child: ListTile(
                              leading: returnLogo(pickedFiles[index]),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "File: ${p.basename(pickedFiles[index].path)}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
            SizedBox(height: 30),
            translatedFiles.isEmpty
                ? SizedBox(
                    height: 50,
                    width: 200,
                    child: InkWell(
                      onTap: translateFiles,
                      child: Card(
                        color: const Color.fromARGB(255, 80, 74, 74),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Translate',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                              ),
                              Icon(
                                Icons.swap_vert,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 5),
            SwitchButton(
              onLanguageChanged: (isEnglishSelected) {
                setState(() {
                  isEnglish = isEnglishSelected;
                });
              },
            ),
            if (_isLoading)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _loadingMessage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        SpinKitChasingDots(
                          color: const Color.fromARGB(255, 74, 68, 68),
                          size: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(height: 30),
            translatedFiles.isNotEmpty
                ? ListView.builder(
                    itemCount: translatedFiles.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            downloadTranslatedFile(translatedFiles[index]),
                        child: Card(
                          color: const Color.fromARGB(255, 74, 80, 80),
                          child: ListTile(
                            leading: Icon(
                              Icons.file_download,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Download Translated File',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
            SizedBox(height: 30),
            // Container for output display
            SizedBox(
              height: 120,
              width: 350,
              child: translatedFiles.isNotEmpty
                  ? InkWell(
                      child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: translatedFiles.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () => openFile(pickedFiles[index]),
                                  title: Text(
                                    'Translated File: ${p.basename(translatedFiles[index].path)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                                  ),
                                );
                              },
                            ),
                          )),
                    )
                  : Center(
                      child: Text(
                        "No Translated Files Available",
                        style: TextStyle(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

Widget returnLogo(File file) {
  return Icon(
    Icons.description,
    color: Colors.white,
  );
}
