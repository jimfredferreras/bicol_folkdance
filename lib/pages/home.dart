import 'package:bicol_folkdance/pages/generate_opening.dart';
import 'package:flutter/material.dart';
import 'package:bicol_folkdance/pages/classify_opening.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/startbg.jpg'), // Replace with your image path
            fit: BoxFit.cover, // Adjust the image fit as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClassifyOpening()),
                      );
                      // Implement functionality for Classification button
                    },
                    icon: Image.asset(
                      'assets/classification_button.png', // Replace with your image path
                      width: 100, // Adjust width as needed
                      height: 100, // Adjust height as needed
                    ),
                  ),
                  const SizedBox(height: 5), // Add space between icon and text
                  const Text(
                    'C L A S S I F Y',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20), // Set text color to white
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add space between buttons
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GenerateOpening()),
                      );
                      // Implement functionality for Generation button
                    },
                    icon: Image.asset(
                      'assets/generate_button.png', // Replace with your image path
                      width: 100, // Adjust width as needed
                      height: 100, // Adjust height as needed
                    ),
                  ),
                  const SizedBox(height: 5), // Add space between icon and text
                  const Text(
                    'G E N E R A T E',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20), // Set text color to white
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'BFD',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}
