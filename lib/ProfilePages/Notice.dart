import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newitem_alarm/ProfilePages/NoticeList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notice extends StatelessWidget {
  String datetime;
  String title;
  String description;
  Notice({Key key,  this.datetime, this.title, this.description}) : super(key: key);
  CollectionReference noticeRef = FirebaseFirestore.instance.collection("Notice");

  @override
  Widget build(BuildContext context) {
    List data_list = [];
    noticeRef.get().then((value) => value.docs.forEach((element) {data_list.add(element.data());}));
    datetime = data_list[0];
    title = data_list[1];
    description = data_list[2];
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
                                  Text(document["Title"],
                                    style:TextStyle(
                                      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(formattedDate.toString(),
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
                          MaterialPageRoute(builder: (context) => NoticeList()),
                        );
                      },
                    ),
                  );
                }).toList();
            List<Widget> noticeItem = snapshotList.cast<Widget>();

            return CustomScrollView(
              // CustomScrollView는 children이 아닌 slivers를 사용하며, slivers에는 스크롤이 가능한 위젯이나 리스트가 등록가능함
              // CustomScrollView 아래에는
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
                SliverList(
                  // 아이템을 빌드하기 위해서 delegate 항목을 구성함
                  // SliverChildBuilderDelegate는 ListView.builder 처럼 리스트의 아이템을 생성해줌
                  // Padding으로 박스형식으로 끝부분 만들어줌
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



