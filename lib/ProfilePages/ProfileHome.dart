import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newitem_alarm/ProfilePages/AlarmMan.dart';
import 'package:newitem_alarm/ProfilePages/ChangeProfile.dart';
import 'package:newitem_alarm/ProfilePages/CommandMan.dart';
import 'package:newitem_alarm/ProfilePages/Manual.dart';
import 'package:newitem_alarm/ProfilePages/Notice.dart';
import 'package:newitem_alarm/ProfilePages/ReviewMan.dart';
import 'package:newitem_alarm/ProfilePages/SignInScreen.dart';
import 'package:newitem_alarm/ProfilePages/components/sign_from.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
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

  bool _isLogin = true;

  final _menuList = [ReviewMan(), CommandMan(), AlarmMan(), Notice(), Manual()];

  final _menuIcon = [
    Icon(Icons.rate_review_outlined, size: 25, color: Color(0xffFFC845)),
    Icon(Icons.comment, size: 25, color: Color(0xffFFC845)),
    Icon(Icons.circle_notifications_outlined,
        size: 25, color: Color(0xffFFC845)),
    Icon(Icons.campaign, size: 25, color: Color(0xffFFC845)),
    Icon(Icons.description_outlined, size: 25, color: Color(0xffFFC845)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Color(0xffFFC845),
          leading: TextButton(
            child: Text('로그아웃'),
            onPressed: () {
              setState(() {
                _isLogin == false;
              });
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'My Page',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    _isLogin = false;
                  });
                },
              child: Text('로그아웃', style: TextStyle(color: Color(0xffFFC845), fontWeight: FontWeight.bold),)
            )

          ],
        ),
        body: func(_isLogin));
  }

  // 로그인/회원가입, 프로필 페이지
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

  // 프로필
  Widget LoginProfile() {
    return Card(
        color: Colors.white,
        //padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(14),
              ),
              //프로필 사진
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(),
                      shape: BoxShape.circle),
                  // padding:
                  //     EdgeInsets.only(left: 20, right: 30, top: 20, bottom: 20),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: _imagePath.length == 0
                        ? AssetImage('assets/images/profile3.png')
                        : FileImage(File(_imagePath)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),

              //프로필 이름
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 15,
                  )
                ],
              )
            ],
          ),
        ));
  }

  // 프로필 수정
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
                      " 프로필 수정하기",
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
        });
  }

  // 리뷰 관리, 댓글 관리...
  Widget ListMenu() {
    return Expanded(
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListView(
          //padding: EdgeInsets.all(8),
          children: [
            //리뷰 관리 페이지 이동
            _MenuListTile(0, "리뷰 관리"),

            //댓글 관리 페이지 이동
            _MenuListTile(1, "댓글 관리"),

            //알림 설정 페이지 이동
            _MenuListTile(2, "알림설정"),

            //공지사항 페이지 이동
            _MenuListTile(3, "공지사항"),

            //이용약관 페이지 이동
            _MenuListTile(4, "이용약관"),
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
              //color: Colors.transparent,
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Text("간편 로그인",
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black87)),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  //여기서부터 동그라미 로그인 버튼 구현
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:5),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SizedBox(
                            height: 60,
                            width: 60,
                             child: ElevatedButton(
                                child: Image.asset(
                                    'assets/images/google_logo.png'),
                                onPressed: signInWithGoogle,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: CircleBorder(),
                                ),
                              )
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right:10, left: 10),
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
                                onPressed: signInWithFacebook,
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
              )),
            ),
          ),
          _NoListMenu(),
        ]);
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

  // 비로그인 메뉴 리스트
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
                      children: [Center(child: Text("로그인이 필요합니다."))],
                    )),
                    actions: <Widget>[
                      Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffFFC845),
                              ),
                              child: Text("확인"),
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
            //리뷰 관리 페이지 이동
            _NoMenuListTile(0, "리뷰 관리"),

            //댓글 관리 페이지 이동
            _NoMenuListTile(1, "댓글 관리"),

            //알림 설정 페이지 이동
            _MenuListTile(2, "알림설정"),

            //공지사항 페이지 이동
            _MenuListTile(3, "공지사항"),

            //이용약관 페이지 이동
            _MenuListTile(4, "이용약관"),
          ],
        ),
      ),
    );
  }
}
