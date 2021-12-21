import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "먹어봤니?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 59.0,
                fontWeight: FontWeight.bold,
        ),
        ),
      )
    );
  }
}