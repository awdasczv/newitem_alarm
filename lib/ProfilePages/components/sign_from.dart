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
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
          ),
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
    return Center(
        child: GestureDetector(
          child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                //border: Border.all(color: Colors.black12, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 3.0,
                  )
                ]
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(3),
                  ),
                  Container(
                    //backgroundImage: AssetImage('assets/images/google_button.png'),
                    padding: EdgeInsets.all(5),
                    child: Image.asset('assets/images/google_button.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(9),
                  ),
                  Container(
                    child: Text("Google 로그인"),
                  ),
                ],
              )
          ),
          onTap: signInWithGoogle,
        )
    );
  }

}


