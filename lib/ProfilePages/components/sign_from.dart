import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newitem_alarm/constants.dart';
import 'package:newitem_alarm/ProfilePages/components/default_button.dart';
import 'package:newitem_alarm/ProfilePages/components/form_error.dart';

class SignFrom extends StatefulWidget {
  const SignFrom({Key key}) : super(key: key);

  @override
  _SignFromState createState() => _SignFromState();
}

class _SignFromState extends State<SignFrom> {

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("로그인",style: TextStyle(color: Colors.black,)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GoogleButtonStyle(),
          /*ElevatedButton(
                onPressed: signInWithGoogle,
                child: Text("회원가입")
            ),*/
        ],
      ),
    );
  }

  Widget GoogleButtonStyle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: GestureDetector(
            child: Image.asset('assets/images/google_button.png'),
            onTap: signInWithGoogle,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Center(
          child: GestureDetector(
            child: Image.asset('assets/images/naver_button.png'),
            onTap: signInWithGoogle,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Center(
          child: GestureDetector(
            child: Image.asset('assets/images/google_button.png'),
            onTap: signInWithGoogle,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
        Center(
          child: GestureDetector(
            child: Image.asset('assets/images/google_button.png'),
            onTap: signInWithGoogle,
          ),
        )
      ],
    );
    /*Center(
        child: GestureDetector(
          child: Image.asset('assets/images/google_button.png'),
          onTap: signInWithGoogle,
        )
    );*/
  }

}


