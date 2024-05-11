import 'package:bicol_folkdance/pages/home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const GenerationDone(jsonData: null));
}

class GenerationDone extends StatelessWidget {
  final dynamic jsonData;

  const GenerationDone({Key? key, required this.jsonData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String base64Gif = jsonData['gif'];
    final double fidScore = jsonData['fid_score'];
    final double isMean = jsonData['inception_score_plus'];
    final double isStd = jsonData['inception_score_minus'];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/output_generationdone.jpg'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover, // Adjust the image fit as needed
          ),
        ),
        child: Stack(
          children: [
            // GIF Container
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.4, // Adjust top position as needed
              left: MediaQuery.of(context).size.width *
                  0.0, // Adjust left position as needed
              child: Image.memory(
                base64Decode(base64Gif),
                width: 400, // Adjust width as needed
                height: 280, // Adjust height as needed
              ),
            ),
            Positioned(
              bottom: 100, // Adjust bottom position as needed
              left: 150, // Adjust left position as needed
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
                  'D O N E',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
            ),
            // Evaluation Result Container
            Positioned(
              bottom: 180, // Adjust bottom position as needed
              left: 0,
              right: 0,
              child: Container(
                height: 60, // Adjust height as needed
                alignment: Alignment.center,
                child: Text(
                  'FID Score: $fidScore\nInception Score (+): $isMean\nInception Score (-): $isStd',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ), // Adjust text style as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
