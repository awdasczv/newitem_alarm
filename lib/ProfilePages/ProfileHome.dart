import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/ReviewMan.dart';
import 'package:newitem_alarm/ProfilePages/CommandMan.dart';
import 'package:newitem_alarm/ProfilePages/LikeMan.dart';
import 'package:newitem_alarm/ProfilePages/AlarmMan.dart';
import 'package:newitem_alarm/ProfilePages/Notice.dart';
import 'package:newitem_alarm/ProfilePages/Manual.dart';
import 'package:newitem_alarm/ProfilePages/ChangeProfile.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                color: Colors.blue,
                child: Center(
                  child: Text("My Page",
                    style: TextStyle(fontSize: 20),
                    //textAlign: TextAlign.center,
                  ),
                )
              ),
              Container(
                  color: Colors.blue,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                        padding: EdgeInsets.all(15),
                        child: GestureDetector(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white54,
                              backgroundImage: AssetImage('assets/images/profile3.png'),
                            ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChangeProfile()),
                            );
                          }
                        )
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left),
                          Text("Date",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.left)
                        ],
                      )

                    ],
                  )
              ),
               Expanded(
                   child: Container(
                       child: ListView(
                         padding: EdgeInsets.all(8),
                         children: [
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

                           ListTile(
                               onTap: () {
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => LikeMan()),
                                 );
                               },
                               title : Text("찜 목록",
                                   style: TextStyle(fontSize: 25),
                                   textAlign: TextAlign.left)
                           ),

                           Divider(
                               color: Colors.black,
                               thickness: 0.5,
                               endIndent: 10.0
                           ),

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
