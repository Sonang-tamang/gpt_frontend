// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt_frontend/components/my_textfield.dart';
import 'package:gpt_frontend/welcome_page/welcome.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GenralChatPage extends StatefulWidget {
  const GenralChatPage({super.key});

  @override
  State<GenralChatPage> createState() => _GenralChatPageState();
}

class _GenralChatPageState extends State<GenralChatPage> {
  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: const Text(
            "General Chat",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 226, 229, 234),
            ),
          ),

          // IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context); // Navigate back to the previous page
          //   },
          // ),
          // actions: [
          //   Builder(
          //     builder: (context) => IconButton(
          //       icon: Icon(Icons.menu), // This will open the drawer
          //       onPressed: () {
          //         Scaffold.of(context).openEndDrawer(); // Opens the drawer
          //       },
          //     ),
          //   ),
          // ],
        ),
        // endDrawer: Drawer(
        //   child: ListView(
        //     children: [
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: const Color.fromARGB(255, 72, 78, 83),
        //         ),
        //         child: Text(
        //           'Menu',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         leading: IconButton(
        //             onPressed: goto_Welcome,
        //             icon: Icon(
        //               Icons.home,
        //               color: Colors.black,
        //               size: 30,
        //             )),
        //         title: Text('Home'),
        //         onTap: goto_Welcome,
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.settings),
        //         title: Text('Settings'),
        //         onTap: () {
        //           Navigator.pop(context); // Closes the drawer
        //         },
        //       ),
        //       // Add more items here
        //     ],
        //   ),
        // ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 72, 78, 83),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: goto_Welcome,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 30,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context); // Closes the drawer
                },
              ),
              // Add more items here
            ],
          ),
        ),
        body: DashChat(
          inputOptions: InputOptions(trailing: [
            IconButton(
              onPressed: _sendMediaMessage,
              icon: const Icon(Icons.image),
            )
          ]),
          currentUser: currentUser,
          onSend: _sendMessage,
          messages: messages,
        ));
  }

  void goto_Welcome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage);
    }
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
  }
}
