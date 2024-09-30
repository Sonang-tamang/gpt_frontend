import 'package:flutter/material.dart';
import 'package:gpt_frontend/components/my_textfield.dart';

class GenralChatPage extends StatefulWidget {
  const GenralChatPage({super.key});

  @override
  State<GenralChatPage> createState() => _GenralChatPageState();
}

class _GenralChatPageState extends State<GenralChatPage> {
//chat users for AI#######################################################################

  // List<String> messages = [];
  // TextEditingController _controller = TextEditingController();

  // ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  // ChatUser aiUser = ChatUser(id: "1", firstName: "RAN Ai");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text(
          "General Chat Mode",
          style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 226, 229, 234)),
        ),
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          SizedBox(
            height: 400,
          ),
          MyTextfield()
        ],
      ),
    );
  }
}
