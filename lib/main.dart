import 'package:flutter/material.dart';
import 'package:bicol_folkdance/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OpeningPage(),
    );
  }
}

class OpeningPage extends StatelessWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/bg2.jpg'), // Replace with your background image path
              fit: BoxFit.cover, // Cover the entire screen
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 40.0), // Adjust the height of the empty space
                Image.asset(
                  'assets/logo.png', // Replace 'assets/logo.png' with your image asset path
                  width: 200.0, // Customize image width
                  height: 200.0, // Customize image height
                ),
                const SizedBox(
                    height: 50.0), // Add space between image and text
                const Text(
                  'Tap anywhere to get started . . .', // Customize text
                  style: TextStyle(
                    color: Colors.white, // Customize text color
                    fontSize: 18.0, // Customize text size
                    fontWeight: FontWeight.bold, // Customize text weight
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
