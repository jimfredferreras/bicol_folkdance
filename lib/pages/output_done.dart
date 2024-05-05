// DAPAT DITO NA MA LABAS ANG OUTPUT NA GALING SA MODEL KAPAG SUCESS ANG SA CLASSIFICATION

import 'package:bicol_folkdance/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClassificationDone extends StatelessWidget {
  final Map<String, dynamic> prediction;
  const ClassificationDone({super.key, required this.prediction});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/output_done.jpg'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover, // Adjust the image fit as needed
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                height: 350,
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Dance: ${prediction['dance'].toString()}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Score: ${prediction['score'].toString()}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Statistics:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              for (var entry in prediction['stats'].entries)
                                Text(
                                  "${entry.key}: ${entry.value}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              top: 320,
              left: 50,
            ),
            Positioned(
              bottom: 80, // Adjust bottom position as needed
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
                  'D O N E',
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
