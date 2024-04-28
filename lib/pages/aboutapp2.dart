import 'package:flutter/material.dart';
import 'package:bicol_folkdance/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AboutPage2(),
    );
  }
}

class AboutPage2 extends StatelessWidget {
  const AboutPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/howbg.jpg'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover, // Adjust the image fit as needed
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 60, // Adjust bottom position as needed
              left: 160, // Adjust left position as needed
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the new page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.lightBlue, // Set background color to light blue
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'N E X T',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
