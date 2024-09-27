import 'package:flutter/material.dart';

class GenralChatPage extends StatefulWidget {
  const GenralChatPage({super.key});

  @override
  State<GenralChatPage> createState() => _GenralChatPageState();
}

class _GenralChatPageState extends State<GenralChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "General Chat Mode",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const Drawer(),
    );
  }
}
