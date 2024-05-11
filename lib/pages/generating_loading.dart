import 'dart:convert';
import 'package:bicol_folkdance/pages/output_generationdone.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeneratingLoading extends StatefulWidget {
  const GeneratingLoading({Key? key, required jsonData}) : super(key: key);

  @override
  _GeneratingLoadingState createState() => _GeneratingLoadingState();
}

class _GeneratingLoadingState extends State<GeneratingLoading> {
  @override
  void initState() {
    super.initState();
    _makeGetRequest();
  }

  Future<void> _makeGetRequest() async {
    final url =
        'http://103.180.163.187:60100/generate'; // Replace with your API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // GET request successful
      final jsonData = json.decode(response.body);
      // Process the JSON data
      print('Response data: $jsonData');

      // Navigate to the next page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GenerationDone(
              jsonData: jsonData), // Pass the JSON data to the next page
        ),
      );
    } else {
      // Handle error case
      print('GET request failed with status: ${response.statusCode}');
    }
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
