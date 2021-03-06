import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newitem_alarm/ProfilePages/NoticeDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeHome extends StatelessWidget {
  CollectionReference noticeRef = FirebaseFirestore.instance.collection("Notice");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: noticeRef.snapshots(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xffFFC845))),
            );
          }
          else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          else {
            List<dynamic> snapshotList = snapshot.data.docs.map(
                    (DocumentSnapshot document)
                {
                  Timestamp tt = document["datetime"];
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                  String datetime = formattedDate.toString();
                  String title = document["Title"].toString();
                  String description = document["description"].toString();
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GestureDetector(
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(title,
                                    style:TextStyle(
                                      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(datetime,
                                  style: TextStyle(color:  Colors.grey[600]),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  document["description"],
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NoticeDetail(datetime: datetime, title: title, description: description)),
                        );
                      },
                    ),
                  );
                }).toList();
            List<Widget> noticeItem = snapshotList.cast<Widget>();
            return CustomScrollView(
              // CustomScrollView??? children??? ?????? slivers??? ????????????, slivers?????? ???????????? ????????? ???????????? ???????????? ???????????????
              // CustomScrollView ????????????
              slivers: <Widget>[
                // ?????? ??????
                SliverAppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title : Container(
                    child: Text("????????????",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
                    ),
                  ),
                  // floating ??????. SliverAppBar??? ????????? ???????????? ?????? ?????? ?????????.
                  // true: ????????? ??? ?????? ????????? ?????? ?????????. false: ????????? ??? ???????????? ????????? ??? ??? ????????? ????????? ?????????
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.black)
                  ),
                  floating: true,
                  snap: true,
                  // ?????? ??????
                  expandedHeight: 50,
                ),
                SliverList(
                  // ???????????? ???????????? ????????? delegate ????????? ?????????
                  // SliverChildBuilderDelegate??? ListView.builder ?????? ???????????? ???????????? ????????????
                  // Padding?????? ?????????????????? ????????? ????????????
                    delegate:SliverChildListDelegate(noticeItem)
                )
              ],
            );
          }
        },
      )
    );
  }
}



