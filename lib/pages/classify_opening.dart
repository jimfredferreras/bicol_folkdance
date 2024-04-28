import 'package:flutter/material.dart';
import 'package:bicol_folkdance/pages/classify_upload.dart';

class ClassifyOpening extends StatelessWidget {
  const ClassifyOpening({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delay duration
    const delayDuration =
        Duration(seconds: 1); // Adjust the delay time as needed

    // Navigate to the next page after the delay
    Future.delayed(delayDuration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ClassifyUpload(), // Navigate to the next page
        ),
      );
    });

    // Return a scaffold with a loading indicator or any other UI
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/classloading.jpg'), // Background image
            fit: BoxFit.cover, // Cover the whole container
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                'C L A S S I F I C A T I O N',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
                height: 50.0), // Add space between text and indicator
            Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white), // Change indicator color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'BFD',
    home: ClassifyOpening(),
  ));
}
