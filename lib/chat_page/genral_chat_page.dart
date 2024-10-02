import 'package:flutter/material.dart';
import 'package:gpt_frontend/components/my_textfield.dart';

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text(
          "General Chat Mode",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 226, 229, 234),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu), // This will open the drawer
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // Opens the drawer
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
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
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Closes the drawer
              },
            ),
            // Add more items here
          ],
        ),
      ),
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
