import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true, // Centers the title in the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the text vertically
          children: <Widget>[
            Icon(Icons.home, size: 100, color: Colors.blue), // Added an icon to make it more visual
            SizedBox(height: 20), // Adds space between the icon and the text
            Text(
              "Welcome to Home Screen!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example action on button press
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Button pressed!')),
                );
              },
              child: Text("Press Me"),
            ),
          ],
        ),
      ),
    );
  }
}
