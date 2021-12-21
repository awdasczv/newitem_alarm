import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/components/sign_from.dart';


class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "로그인",
          style: TextStyle(
          color: Colors.black,
        ),
        ),
      ),

        body: SignFrom(),


      //body: SignFrom(),

    );
  }
}


