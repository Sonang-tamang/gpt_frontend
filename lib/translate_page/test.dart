// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

// defult loding###########################################################
  bool _isLoading = false;

  // Method to pick fils #######################################################################
  pickFiles() async {
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

  openFile(File file) async {
    OpenFile.open(file.path);
    var result = await OpenFile.open(file.path);
    print(result.message);
  }
  // Print any error message

  Future<void> translateFiles() async {
    if (pickedFiles.isEmpty) return;

    try {
      for (var file in pickedFiles) {
        print('Sending file: ${file.path}');

        // Prepare the multipart request
        var url = Uri.parse("http://192.168.17.111:8000/api/translate_docx/");
        var request = http.MultipartRequest('POST', url);

        // Add the file as part of the request
        request.files.add(await http.MultipartFile.fromPath(
          'file', // Make sure this is the correct field name expected by the API
          file.path,
          contentType: MediaType('application',
              'vnd.openxmlformats-officedocument.wordprocessingml.document'),
        ));

        request.fields['source_language'] = 'ne'; // Source language
        request.fields['target_language'] = 'en'; // Target language

        // Send the request to the API
        var response = await request.send();

        // Handle the response
        if (response.statusCode == 200) {
          print('File translated successfully!');
          var responseData = await http.Response.fromStream(response);

          // Save the translated file locally
          Directory tempDir = await getTemporaryDirectory();
          String filePath =
              '${tempDir.path}/translated_${p.basename(file.path)}';
          File translatedFile = File(filePath);

          await translatedFile
              .writeAsBytes(responseData.bodyBytes); // Write file bytes
          print('Translated file saved at: $filePath');

          // Add translated file to the list and update UI
          setState(() {
            translatedFiles.add(translatedFile);
          });
        } else {
          print(
              'Failed to translate file. Status code: ${response.statusCode}');
          var responseData = await http.Response.fromStream(response);
          print('Response body: ${responseData.body}');
        }
      }
    } catch (e) {
      print('Error while translating files: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> downloadTranslatedFile(File translatedFile) async {
    // Check and request storage permission
    var status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        // Get the download directory on Android
        Directory? downloadsDir = Directory('/storage/emulated/0/Download');
        if (!downloadsDir.existsSync()) {
          downloadsDir.createSync();
        }

        // Create new file path
        String newFilePath =
            '${downloadsDir.path}/translated_${p.basename(translatedFile.path)}';

        // Write the file
        File newFile = File(newFilePath);
        await newFile.writeAsBytes(await translatedFile.readAsBytes());

        // Notify user of successful download
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('File downloaded to Downloads folder'),
        ));
      } catch (e) {
        // Handle any errors during file writing
        print('Error saving file: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error downloading file: $e'),
        ));
      }
    } else if (status.isDenied) {
      // If permission is denied, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Storage permission denied'),
      ));
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, prompt user to go to settings
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
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
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
            SizedBox(
              height: 50,
              width: 200,
              child: InkWell(
                onTap: translateFiles, // Call translateFiles on tap
                child: Card(
                  color: const Color.fromARGB(255, 80, 74, 74),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isLoading
                            ? CircularProgressIndicator(
                                color: const Color.fromARGB(255, 255, 255, 255))
                            : Text(
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
            ),
            SizedBox(height: 30),
            // Display the translated files and download button
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
                            leading: Icon(Icons.download, color: Colors.white),
                            title: Text(
                              "Download: ${p.basename(translatedFiles[index].path)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
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
              height: 160,
              width: 350,
              child: Card(
                color: Colors.white,
                child: translatedFiles.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: translatedFiles.length,
                          itemBuilder: (context, index) {
                            return ListTile(
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
                      )
                    : Center(
                        child: Text(
                          "No Translated Files Available",
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Icon returnLogo(File file) {
  var ex = p.extension(file.path);

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
