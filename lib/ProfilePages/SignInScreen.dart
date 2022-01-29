import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/components/sign_from.dart';
import 'package:newitem_alarm/src/app.dart';

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

        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if(!snapshot.hasData) {
                return SignFrom();
              }
              else if(snapshot.hasError){
                return Center(
                  child: Text('로그인 실패'),
                );
              }
              else {
                Navigator.pop(context,true);
                return null;
              }
          },
        )
        //SignFrom(),


      //body: SignFrom(),

    );
  }
}


