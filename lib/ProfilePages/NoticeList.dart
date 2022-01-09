import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/NoticeList_body.dart';
import 'package:newitem_alarm/ProfilePages/NoticeList_header.dart';


class NoticeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("공지사항",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)
        ),
      ),
      body: ListView(
        children: [
          NoticeList_header(),
          //NoticeList_header 값을 받음
      Padding(
        padding: const EdgeInsets.only(bottom: 1.0),
          child:NoticeList_body(), //NoticeList_body 값을 받음
      ),
        ],
      ),
    );
  }
}


