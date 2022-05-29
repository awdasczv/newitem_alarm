import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:intl/intl.dart';
import 'package:newitem_alarm/ProfilePages/NoticeDetail.dart';

class NoticeDetail extends StatelessWidget {
  final String datetime;
  final String title;
  final String description;
  NoticeDetail({Key key,  this.datetime, this.title, this.description}) : super(key: key);
  CollectionReference noticeRef = FirebaseFirestore.instance.collection("Notice");

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
      body:ListView(
        children: [
          SizedBox(height: 5,),
          NoticeHeader(datetime, title),
          Padding(padding: const EdgeInsets.only(bottom: 10),
            child:NoticeBody(description),
          )
        ],
      ),
    );
  }
}


Widget NoticeHeader(String datetime, String title) {
  CollectionReference noticeRef = FirebaseFirestore.instance.collection("Notice");
  return Card(
    margin: EdgeInsets.only(bottom: 12.0),
    elevation: 0.5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title,
                style: TextStyle(
                  color:  Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold,
                ),
              ),
              Text(datetime,
                style: TextStyle(color:  Colors.grey[600]),
              )
            ],
          )
        ],
      ),
    ),
  );
}





Widget NoticeBody(String description){
  CollectionReference noticeRef = FirebaseFirestore.instance.collection("Notice");
  return SafeArea(
      child: SizedBox(
        width: 800,
        height: 800,
        child: Column(
          children: [
            SizedBox(
              width: 800,
              height: 800,
              child: Container(
                padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                color: Colors.white,
                child: Text(description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0, fontWeight: FontWeight.bold,)
                ),
              ),
            ),
          ],
        ),
      )
  );
}