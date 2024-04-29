import 'package:bicol_folkdance/pages/generating_loading.dart';
import 'package:flutter/material.dart';

class GenerateDance extends StatelessWidget {
  const GenerateDance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/bg3.jpg', // Assuming bg_app.jpg is in the assets folder
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GeneratingLoading()),
                  );
                },
                child: SizedBox(
                  width: 160, // Adjust width as needed
                  height: 160, // Adjust height as needed
                  child: Image.asset(
                    'assets/letsdance.png', // Assuming letsdance.png is in the assets folder
                    fit: BoxFit
                        .contain, // You can adjust the fit based on your requirements
                  ),
                ),
              ),
              SizedBox(
                height: 10, // Add some space between the button and text
              ),
              Text(
                "L E T ' S   D A N C E",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
