import 'dart:io';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/ReviewMan.dart';
import 'package:newitem_alarm/ProfilePages/CommandMan.dart';
import 'package:newitem_alarm/ProfilePages/AlarmMan.dart';
import 'package:newitem_alarm/ProfilePages/Notice.dart';
import 'package:newitem_alarm/ProfilePages/Manual.dart';
import 'package:newitem_alarm/ProfilePages/ChangeProfile.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {

  String _name = "이름";
  String _imagePath = "";
  final ImagePicker _picker = ImagePicker();
  PickedFile _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.orangeAccent,
                child: Center(
                  child: Text("My Page",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                    //textAlign: TextAlign.center,
                  ),
                )
              ),
              Container(
                  color: Colors.orangeAccent,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //프로필 사진
                      Container(
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.only(left: 20, right: 30, top: 20, bottom: 20),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white54,
                            backgroundImage: _imagePath.length == 0 ? AssetImage('assets/images/profile3.png') : FileImage(File(_imagePath)),
                          ),
                      ),

                      //프로필 이름
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(_name,
                              style: TextStyle(fontSize: 30, color: Colors.white),
                              textAlign: TextAlign.center),
                          /*Text("Date",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left)*/
                        ],
                      )

                    ],
                  )
              ),

              //프로필 수정
              GestureDetector(
                child: Container(
                  color: Colors.orangeAccent,
                  padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, color: Colors.white,),
                      Text(" 프로필 수정하기", style: TextStyle(fontSize: 25, color: Colors.white), )
                    ],
                  )
                ),
                  onTap: () async{
                    var a = await
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeProfile(imagePath: _imagePath)),
                    );
                    setState(() {
                      _imagePath = a[0];
                      _name = a[1];
                    });
                  }
              ),
               Expanded(
                   child: Container(
                       child: ListView(
                         padding: EdgeInsets.all(8),
                         children: [
                           //리뷰 관리 페이지 이동
                           ListTile (
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => ReviewMan()),
                               );
                             },



                               title : Text("리뷰 관리",
                                   style: TextStyle(fontSize: 25),
                                   textAlign: TextAlign.left )
                           ),

                           Divider(
                             color: Colors.black,
                             thickness: 0.5,
                             endIndent: 10.0
                           ),


                           //댓글 관리 페이지 이동
                           ListTile(
                               onTap: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => CommandMan()),
                                 );
                               },
                               title : Text("댓글 관리",
                                   style: TextStyle(fontSize: 25),
                                   textAlign: TextAlign.left)
                           ),

                           Divider(
                               color: Colors.black,
                               thickness: 0.5,
                               endIndent: 10.0
                           ),

                           //알림 설정 페이지 이동
                           ListTile(
                               onTap: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => AlarmMan()),
                                 );
                               },
                               title : Text("알림설정",
                                   style: TextStyle(fontSize: 25),
                                   textAlign: TextAlign.left)
                           ),

                           Divider(
                               color: Colors.black,
                               thickness: 0.5,
                               endIndent: 10.0
                           ),

                           //공지사항 페이지 이동
                           ListTile(
                               onTap: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => Notice()),
                                 );
                               },
                               title : Text("공지사항",
                                   style: TextStyle(fontSize: 25),
                                   textAlign: TextAlign.left)
                           ),

                           Divider(
                               color: Colors.black,
                               thickness: 0.5,
                               endIndent: 10.0
                           ),

                           //이용약관 페이지 이동
                           ListTile(
                               onTap: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => Manual()),
                                 );
                               },
                               title : Text("이용약관",
                                   style: TextStyle(fontSize: 25),
                                   textAlign: TextAlign.left)
                           ),

                           Divider(
                               color: Colors.black,
                               thickness: 0.5,
                               endIndent: 10.0
                           ),



                         ],
                       )
                   )
               )
            ]
        )
    );
  }
}
