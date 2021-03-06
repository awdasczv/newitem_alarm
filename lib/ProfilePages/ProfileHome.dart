import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newitem_alarm/ProfilePages/AlarmMan.dart';
import 'package:newitem_alarm/ProfilePages/ChangeProfile.dart';
import 'package:newitem_alarm/ProfilePages/CommandMan.dart';
import 'package:newitem_alarm/ProfilePages/Manual.dart';
import 'package:newitem_alarm/ProfilePages/NoticeHome.dart';
import 'package:newitem_alarm/ProfilePages/ReviewMan.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newitem_alarm/ProfilePages/SignInScreen.dart';
import 'package:newitem_alarm/ProfilePages/components/sign_from.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      checkProfileImage();
      User _user = FirebaseAuth.instance.currentUser;
      return;
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider
        .credential(loginResult.accessToken.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  String _name = "";
  String _imagePath = "";
  final ImagePicker _picker = ImagePicker();
  PickedFile _image;

  bool _isLogin;
  User _user;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _isLogin = _user != null;
  }

  final _menuList = [ReviewMan(), CommandMan(), AlarmMan(), NoticeHome(), Manual()];

  final _menuIcon = [
    Icon(Icons.rate_review_outlined, size: 25, color: Color(0xffFFC845)),
    Icon(Icons.comment, size: 25, color: Color(0xffFFC845)),
    Icon(Icons.circle_notifications_outlined,
        size: 25, color: Color(0xffFFC845)),
    Icon(Icons.campaign, size: 25, color: Color(0xffFFC845)),
    Icon(Icons.description_outlined, size: 25, color: Color(0xffFFC845)),
  ];


  Widget IsLogoutButton() {
    if(_isLogin == true)
      {
        return TextButton(
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              setState(() {
                _isLogin = false;
              });
            },
            child: Text('????????????', style: TextStyle(color: Color(0xffFFC845), fontWeight: FontWeight.bold),)
        );
      }
    else
      {
        return Text("");
      }
  }

  /// ???????????? ??? ??? ????????? ?????? ?????? ??????
  static DateTime currentBackPressTime;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  onPressBackButton() {
    DateTime now = DateTime.now();
    if(currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2))
      {
        currentBackPressTime = now;
        Fluttertoast.showToast(
          msg: ("???????????? ????????? ??? ??? ??? ????????? ???????????????."),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey
        );
        return false;
      }
      return true;
  }
  /// ???????????? ??? ??? ????????? ?????? ?????? ??????

  @override
  Widget build(BuildContext context) {
    // ???????????? ??? ??? ????????? ????????? ??????
    return WillPopScope(
      onWillPop: () async {
        bool result = onPressBackButton();
        return await result;
      },
      child: Scaffold(
        key: _globalKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'My Page',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
            ),
            actions: [
              IsLogoutButton()
            ],
          ),
          body: func(_isLogin))
    );
  }

  // ?????????/????????????, ????????? ?????????
  Widget func(bool _isLogin) {
    if (_isLogin == true) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LoginProfile(),
            ProfileImage(),
            ListMenu()
            //func(_isLogin)
          ]);
    } else {
      return b();
    }
  }

  Widget LoginProfile(){
    return Card(
      color: Colors.white,
      child : SizedBox(
        height: 220, width: 500,
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color:Colors.black,
                border: Border.all(),
                  shape: BoxShape.circle),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: _imagePath.length == 0
                    ? AssetImage('assets/images/profile3.png')
                    : FileImage(File(_imagePath)),
                //child: CameraIcon(),
              ),
            ),
            SizedBox(width: 10,),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('Developer',
                   style: TextStyle(
                     color: Colors.black,
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold,
                   )
                 ),
                 SizedBox(height: 10,
                 width: 10,),
                 Text(' User #0101',
                 style: TextStyle(
                   color: Colors.grey[500],
                   fontSize: 15.0,
                 ),),

               ],
             ),
          ],
        ),
      ),
      ),
    );
  }

 //????????? ?????????
 Widget CameraIcon(){
    return Stack(
      children :[
        Positioned(
          right: 5,
              bottom: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[100]),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Color(0xffFFC845),
                  size: 20,
                ),
              ),
        ),
      ],
    );
  }

  Widget ProfileImage(){
    return Stack(
      children: [
        Positioned(
          child:GestureDetector(
              child: Center(
                child: Container(
                  height: 58,
                  width: 400,
                  child: Card(
                    //color: Color(0xffFFC845),
                      color: Colors.white,

                      // decoration: BoxDecoration(
                      //   border: Border.all(width: 1),
                      //   color: Colors.transparent,
                      // ),

                      //padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          Text(
                            " ????????? ????????????",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          )
                        ],
                      )),
                ),
              ),
              onTap: () async {
                var a = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeProfile(imagePath: _imagePath)),
                );
                setState(() {
                  _imagePath = a[0];
                  _name = a[1];
                });
              }
          )
        )
      ],
    );
  }

/*
  // ????????? ??????
  Widget ProfileImage() {
    return GestureDetector(
        child: Center(
          child: Container(
            height: 58,
            width: 400,
            child: Card(
              //color: Color(0xffFFC845),
                color: Colors.white,

                // decoration: BoxDecoration(
                //   border: Border.all(width: 1),
                //   color: Colors.transparent,
                // ),

                //padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    Text(
                      " ????????? ????????????",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                    )
                  ],
                )),
          ),
        ),
        onTap: () async {
          var a = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeProfile(imagePath: _imagePath)),
          );
          setState(() {
            _imagePath = a[0];
            _name = a[1];
          });
        }
        );
  }

 */

  // ?????? ??????, ?????? ??????...
  Widget ListMenu() {
    return Expanded(
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListView(
          //padding: EdgeInsets.all(8),
          children: [
            //?????? ?????? ????????? ??????
            _MenuListTile(0, "?????? ??????"),

            //?????? ?????? ????????? ??????
            _MenuListTile(1, "?????? ??????"),

            //?????? ?????? ????????? ??????
            _MenuListTile(2, "????????????"),

            //???????????? ????????? ??????
            _MenuListTile(3, "????????????"),

            //???????????? ????????? ??????
            _MenuListTile(4, "????????????"),
          ],
        ),
      ),
    );
  }

  // _isLogin = false
  Widget b() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Container(
              //color: Color(0xffFFC845),
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text("?????? ?????????",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87)),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),

                      //??????????????? ???????????? ????????? ?????? ??????
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /* Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Text("?????? ?????????",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black87)),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),*/

                          //??????????????? ???????????? ????????? ?????? ??????
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ElevatedButton(
                                        child: Image.asset(
                                            'assets/images/google_logo.png'),
                                        onPressed: ()async{
                                          await signInWithGoogle();
                                          _user = FirebaseAuth.instance.currentUser;
                                          if(_user != null){
                                            setState(() {
                                              _isLogin = true;
                                            });
                                            logInProgress(_user);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: CircleBorder(),
                                        ),
                                      )
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: FittedBox(
                                  child: SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ElevatedButton(
                                        child: Text('f',

                                            style: TextStyle(
                                                fontFamily: 'Facebook',
                                                fontWeight: FontWeight.bold,
                                                height: 1.5,
                                                fontSize: 35,
                                                color: Colors.white)
                                        ),
                                        onPressed: ()async{
                                          await signInWithFacebook();
                                          _user = FirebaseAuth.instance.currentUser;
                                          if(_user != null){
                                            setState(() {
                                              _isLogin = true;
                                            });
                                            logInProgress(_user);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF3B5998),
                                          shape: CircleBorder(),
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
              ),
            ),),
          _NoListMenu(),
        ]);
  }

  void logInProgress(User _user)async{
    CollectionReference userRef = FirebaseFirestore.instance.collection('User');
    DocumentSnapshot snapshot;
    try{
      snapshot = await userRef.doc(_user.uid).get();
    }catch(e){
      print(e);
    }
    if(snapshot.exists){
      print(_user.uid);
      userRef.doc(_user.uid).update({
        'nickname' : _user.displayName,
        'profileImageURL' : _user.photoURL,
        'userID' : _user.email
      });
    }else {
      userRef.doc(_user.uid).set({
        'LikeList':[],
        'myComment':[],
        'myReview':[],
        'nickname' : _user.displayName,
        'profileImageURL' : _user.photoURL,
        'userID' : _user.email
      });
    }
  }

  ListTile _MenuListTile(int index, String name) {
    return ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _menuList[index]),
          );
        },
        title: Row(
          children: [
            _menuIcon[index],
            SizedBox(
              width: 10,
            ),
            Text("${name}",
                style: TextStyle(fontSize: 22), textAlign: TextAlign.left),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Color(0xffFFC845),
            )
          ],
        ));
  }

  // ???????????? ?????? ?????????
  ListTile _NoMenuListTile(int index, String name) {
    return ListTile(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text(""),
                    content: SingleChildScrollView(
                        child: ListBody(
                          children: [Center(child: Text("???????????? ???????????????."))],
                        )),
                    actions: <Widget>[
                      Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffFFC845),
                              ),
                              child: Text("??????"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }))
                    ]);
              });
        },
        title: Row(
          children: [
            _menuIcon[index],
            SizedBox(
              width: 10,
            ),
            Text("${name}",
                style: TextStyle(fontSize: 22), textAlign: TextAlign.left),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Color(0xffFFC845),
            )
          ],
        ));
  }


  Widget _NoListMenu() {
    return Expanded(
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListView(
          //padding: EdgeInsets.all(8),
          children: [
            //?????? ?????? ????????? ??????
            _NoMenuListTile(0, "?????? ??????"),

            //?????? ?????? ????????? ??????
            _NoMenuListTile(1, "?????? ??????"),

            //?????? ?????? ????????? ??????
            _MenuListTile(2, "????????????"),

            //???????????? ????????? ??????
            _MenuListTile(3, "????????????"),

            //???????????? ????????? ??????
            _MenuListTile(4, "????????????"),
          ],
        ),
      ),
    );
  }
}
