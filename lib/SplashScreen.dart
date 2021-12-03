import 'package:flutter/material.dart';
import 'package:newitem_alarm/HomePages/HomePage.dart';
import 'package:newitem_alarm/main.dart';


class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "먹어봤니",
              style: TextStyle(
            color: Colors.black,//Color(0xfff8ffde),
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        ),
      )
    );
  }
}