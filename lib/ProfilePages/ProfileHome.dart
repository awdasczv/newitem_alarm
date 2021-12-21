import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/ReviewMan.dart';
import 'package:newitem_alarm/ProfilePages/CommandMan.dart';
import 'package:newitem_alarm/ProfilePages/AlarmMan.dart';
import 'package:newitem_alarm/ProfilePages/Notice.dart';
import 'package:newitem_alarm/ProfilePages/Manual.dart';
import 'package:newitem_alarm/ProfilePages/ChangeProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newitem_alarm/ProfilePages/SignInScreen.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  String _name = "";
  String _imagePath = "";
  final ImagePicker _picker = ImagePicker();
  PickedFile _image;

  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '프로필',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
        body: func(_isLogin)
    );
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
              //프로필 사진
              Container(
                color: Colors.transparent,
                padding:
                    EdgeInsets.only(left: 20, right: 30, top: 20, bottom: 20),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white54,
                  backgroundImage: _imagePath.length == 0
                      ? AssetImage('assets/images/profile3.png')
                      : FileImage(File(_imagePath)),
                ),
              ),

              //프로필 이름
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_name,
                      style: TextStyle(fontSize: 30,),
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
        child: Container(
          height: 70,
          child: Card(

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
                    color: Colors.white,
                  ),
                  Text(
                    " 프로필 수정하기",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )
                ],
              )),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          child: ListView(
            //padding: EdgeInsets.all(8),
            children: [
              //리뷰 관리 페이지 이동
              ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReviewMan()),
                    );
                  },
                  title: Row(
                    children: [
                      Icon(Icons.rate_review_outlined,size: 30,),
                      SizedBox(width: 10,),
                      Text("리뷰 관리",
                          style: _ts(), textAlign: TextAlign.left),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  )
              ),

              //댓글 관리 페이지 이동
              ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommandMan()),
                    );
                  },
                  title: Row(
                    children: [
                      Icon(Icons.comment,size: 30,),
                      SizedBox(width: 10,),
                      Text("댓글 관리",
                          style: _ts(), textAlign: TextAlign.left),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  )
              ),


              //알림 설정 페이지 이동
              ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlarmMan()),
                    );
                  },
                  title: Row(
                    children: [
                      Icon(Icons.circle_notifications_outlined,size: 30,),
                      SizedBox(width: 10,),
                      Text("알림설정",
                          style: _ts(), textAlign: TextAlign.left),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  )
              ),

              //공지사항 페이지 이동
              ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notice()),
                    );
                  },
                  title: Row(
                    children: [
                      Icon(Icons.campaign,size: 30,),
                      SizedBox(width: 10,),
                      Text("공지사항",
                          style: _ts(), textAlign: TextAlign.left),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  )
              ),

              //이용약관 페이지 이동
              ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Manual()),
                    );
                  },
                  title: Row(
                    children: [
                      Icon(Icons.description_outlined,size: 30,),
                      SizedBox(width: 10,),
                      Text("이용약관",
                          style: _ts(), textAlign: TextAlign.left),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  )),
            ],
          ),
        ),

    );
  }

  // 로그인/회원가입
  /*Widget a() {
    return Center(
        child: ElevatedButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            child: Text("로그인/회원가입",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white))));
  }*/

  // _isLogin = false
  Widget b() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          color: Colors.white70,
          child: Center(
            child: Text(
              "My Page",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
              //textAlign: TextAlign.center,
            ),
          )),
      Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.black,
          width: 1.0,
        ))),
        child: Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Text("로그인/회원가입",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white)))),
      ),
      ListMenu()
      //func(_isLogin)
    ]);
  }

  TextStyle _ts(){
    return TextStyle(
      fontSize: 23
    );
  }
}
