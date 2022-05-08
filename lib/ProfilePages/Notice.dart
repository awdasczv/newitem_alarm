import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/NoticeList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Notice extends StatelessWidget {
  CollectionReference noticeRef = FirebaseFirestore.instance.collection("Notice");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // CustomScrollView는 children이 아닌 slivers를 사용하며, slivers에는 스크롤이 가능한 위젯이나 리스트가 등록가능함
        slivers: <Widget>[
          // 앱바 추가
          SliverAppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title : Container(
              child: Text("공지사항",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
            ),
            ),

            // floating 설정. SliverAppBar는 스크롤 다운되면 화면 위로 사라짐.
            // true: 스크롤 업 하면 앱바가 바로 나타남. false: 리스트 최 상단에서 스크롤 업 할 때에만 앱바가 나타남
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black)
            ),
            floating: true,
            snap: true,
            // 최대 높이
            expandedHeight: 50,
          ),
          StreamBuilder<QuerySnapshot>(
          stream: noticeRef.snapshots(),
          //limit제한, orderBy정렬, where 필터링,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasError)
            {
              return Text("Error : ${snapshot.error}");
            }
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Text("Loading...");
            }
            return SliverList(
              // 아이템을 빌드하기 위해서 delegate 항목을 구성함
              // SliverChildBuilderDelegate는 ListView.builder 처럼 리스트의 아이템을 생성해줌
              // Padding으로 박스형식으로 끝부분 만들어줌
                delegate: SliverChildListDelegate(
                    snapshot.data.docs.map(
                            (DocumentSnapshot snapshot)
                        {
                          Timestamp tt = snapshot["datetime"];
                          DateTime dt = DateTime.fromMicrosecondsSinceEpoch(tt.microsecondsSinceEpoch);
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: 200,
                              color: Colors.grey,
                              child: Text(snapshot["Title"]),
                              ),
                          );
                        }).toList()
                )
            );

              }),
        ],
      ),
    );
  }
}

/*
Widget NoticeBack(){
  return Card
*/