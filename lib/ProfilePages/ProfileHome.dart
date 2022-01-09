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

  bool _isLogin = false;

  final _menuList = [
    ReviewMan(),
    CommandMan(),
    AlarmMan(),
    Notice(),
    Manual()
  ];

  final _menuIcon = [
    Icon(Icons.rate_review_outlined,size: 25,color: Color(0xfff1c40f)),
    Icon(Icons.comment,size: 25,color: Color(0xfff1c40f)),
    Icon(Icons.circle_notifications_outlined,size: 25,color: Color(0xfff1c40f)),
    Icon(Icons.campaign,size: 25,color: Color(0xfff1c40f)),
    Icon(Icons.description_outlined,size: 25,color: Color(0xfff1c40f)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xfff1c40f),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Page',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
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
              Padding(
                padding: EdgeInsets.all(14),
              ),
              //프로필 사진
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(),
                      shape: BoxShape.circle
                  ),
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
                      style: TextStyle(fontSize: 20,),
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
                //color: Color(0xfff1c40f),
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
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
                    Text("더 많은 기능을 사용하시려면"),
                    Text("로그인/회원가입 하십시오."),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xfff1c40f))
                        ),
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignInScreen()));
                        },
                        child: Text("로그인/회원가입",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)
                        )
                    )
                  ],
                )
              ),
            ),
          ),
          ListMenu(),
        ]
      );
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
            SizedBox(width: 10,),
            Text("${name}",
                style: TextStyle(fontSize: 22), textAlign: TextAlign.left),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined, color: Color(0xfff1c40f),)
          ],
        )
    );
  }
}
