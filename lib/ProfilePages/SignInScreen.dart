import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/components/sign_from.dart';
import 'package:newitem_alarm/ProfilePages/ProfileHome.dart';
import 'package:newitem_alarm/src/app.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "로그인페이지",
          style: TextStyle(
          color: Colors.black,
        ),
        ),
      ),
*/
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if(!snapshot.hasData) {
              return SignFrom();
            }else{
              return ProfileHome();
              /*Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${snapshot.data.displayName}님 환영합니다."),
                    ElevatedButton(
                      child: Text("프로필 페이지로 이동"),
                      onPressed: () async {
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ProfileHome()));
                      },
                    ),
                    ElevatedButton(
                      child: Text("로그아웃"),
                      onPressed: FirebaseAuth.instance.signOut,
                    ),
                  ],
                ),
              );*/
            }
          },
        )
      //SignFrom(),


      //body: SignFrom(),

    );
  }
}


