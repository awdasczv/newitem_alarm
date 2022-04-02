import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    checkProfileImage();

    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FittedBox(
            child: Image.asset('assets/images/s.png'),
            fit: BoxFit.cover,
          )
        ));
  }
}