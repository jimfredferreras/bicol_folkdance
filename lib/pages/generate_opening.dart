import 'package:bicol_folkdance/pages/generate_letsdance.dart';
import 'package:flutter/material.dart';

class GenerateOpening extends StatelessWidget {
  const GenerateOpening({Key? key}) : super(key: key);

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
          builder: (context) =>
              const GenerateDance(), // Navigate to the next page
        ),
      );
    });

    // Return a scaffold with a loading indicator or any other UI
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/genloading.jpg'), // Background image
            fit: BoxFit.cover, // Cover the whole container
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                'G E N E R A T I O N',
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
    home: GenerateOpening(),
  ));
}
