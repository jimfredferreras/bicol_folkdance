// ITO MALABAS KAPAG FAILED ANG PAG OUTPUT SA PAG CLASSIFY
import 'package:bicol_folkdance/pages/classify_upload.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ClassificationFailed(),
    );
  }
}

class ClassificationFailed extends StatelessWidget {
  const ClassificationFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/output_failed.jpg'), // Replace 'assets/background_image.jpg' with your image path
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
                    MaterialPageRoute(
                        builder: (context) => const ClassifyUpload()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.lightBlue, // Set background color to light blue
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'T R Y  A G A I N',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
