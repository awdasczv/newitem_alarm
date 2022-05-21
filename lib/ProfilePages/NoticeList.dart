import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NoticeList extends StatelessWidget {
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
          NoticeHeader(),
          Padding(padding: const EdgeInsets.only(bottom: 1.0),
            child:NoticeBody(),
          )
        ],
      ),
    );
  }
}


Widget NoticeHeader() {
  CollectionReference noticeRef = FirebaseFirestore.instance.collection("Notice");
  return Scaffold(
    body: StreamBuilder(
      stream: noticeRef.snapshots(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xffFFC845))),
          );
        }
        else if (snapshot.hasError){
          return Center(child: Text(snapshot.error.toString()));
        }
        else{
          ListView(
            children: snapshot.data.documents.map((DocumentSnapshot document)
            {
              Timestamp tt = document["datetime"];
              DateTime now = DateTime.now();
              String formattedDate = DateFormat('yyyy-MM-dd').format(now);
              return Card(
                margin: EdgeInsets.only(bottom: 12.0),
                elevation: 0.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(document["Title"],
                      style: TextStyle(
                        color:  Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text(formattedDate.toString(),
                        style: TextStyle(color:  Colors.grey[600]),
                      )
                    ],
                  ),
                ),
              );
            }
            ),
          );
        }
      },
    ),
  );
}





Widget NoticeBody(){

}