// ETO NA SCREENS ANG MA APPEAR HABANG NAG GEGENERATE
import 'package:bicol_folkdance/pages/output_generationdone.dart';
import 'package:flutter/material.dart';

class GeneratingLoading extends StatefulWidget {
  const GeneratingLoading({Key? key}) : super(key: key);

  @override
  _GeneratingLoadingState createState() => _GeneratingLoadingState();
}

class _GeneratingLoadingState extends State<GeneratingLoading> {
  @override
  void initState() {
    super.initState();
    // Delay duration
    const delayDuration =
        Duration(seconds: 3); // Adjust the delay time as needed

    // Navigate to the next page after the delay
    Future.delayed(delayDuration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const GenerationDone(), // Navigate to the next page
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/generatingdance_loading.jpg'), // Background image
            fit: BoxFit.cover, // Cover the whole container
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 200, // Adjust top position
              left: MediaQuery.of(context).size.width / 2 -
                  20, // Center horizontally
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
