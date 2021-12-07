import 'package:flutter/material.dart';
import 'package:newitem_alarm/HomePages/HomePage.dart';


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
<<<<<<< Updated upstream
            color: Color(0xffeee6c4),
          fontSize: 59.0,
=======
            color: Colors.black,
          fontSize: 28.0,
>>>>>>> Stashed changes
          fontWeight: FontWeight.bold,
        ),
        ),
      )
    );
  }
}