import 'package:bicol_folkdance/pages/generate_opening.dart';
import 'package:flutter/material.dart';
import 'package:bicol_folkdance/pages/classify_opening.dart';
import 'package:connectivity/connectivity.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/startbg.jpg'),
            fit: BoxFit.cover,
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
                    },
                    icon: Image.asset(
                      'assets/classification_button.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'C L A S S I F Y',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      checkWifiAndNavigate(context);
                    },
                    icon: Image.asset(
                      'assets/generate_button.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'G E N E R A T E',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkWifiAndNavigate(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GenerateOpening()),
      );
    } else {
      // Show a dialog or snackbar indicating no WiFi connection
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Please connect to a network to use the feature 'Generate'."),
        ),
      );
    }
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
