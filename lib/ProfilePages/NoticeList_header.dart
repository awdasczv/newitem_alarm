import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoticeList_header extends StatefulWidget {
  @override
  _NoticeList_headerState createState() => _NoticeList_headerState();

}


class _NoticeList_headerState extends State<NoticeList_header> {


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        //카드모양을 선언하고 엣지값을 줘서 둥글게 잘라 저 형태 바를 만들었음

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ]),
        )
    );
  }
}

/*
            Text("짧은 공지제목입니다.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0, fontWeight: FontWeight.bold,)
            ),
            Text("2021-11-02",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0, fontWeight: FontWeight.bold,
                )
                ),
             */