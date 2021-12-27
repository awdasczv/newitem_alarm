import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/EditReview.dart';

class ReviewMan extends StatefulWidget {

  @override
  _ReviewManState createState() => _ReviewManState();
}

class _ReviewManState extends State<ReviewMan> {

  List<String> _review = [
    "리뷰11111111111111111111111111111111111111",
    "리뷰22222222222222222222222222222222222222222222222",
    "리뷰3333333333333333333333333333333333333",
    "리뷰44444444444444444444444444444444444444444444444444444",
    "리뷰5555555555555555555555555555555"
  ];

  bool _reviewEditButton = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("리뷰 관리",
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("내가 쓴 리뷰", style: TextStyle(fontSize: 28),),
                    Padding(
                        padding: EdgeInsets.only(left: 155),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white10,
                            onPrimary: Colors.black,
                          ),
                          onPressed: () async {
                            var a = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditReview(review: _review)),
                            );
                            if (a != null) {
                              for(int i = 0; i < _review.length; i++) {
                                if (a[i] == true) {
                                  _review[i] = "";
                                }
                              }
                              _review.removeWhere((_review) => _review == "");
                            }
                            setState(() {
                              _reviewEditButton = true;
                            });
                          },
                          child: Text(" 편집"),
                        )
                    )
                  ],
                )
            ),
            Expanded(
              child: _ReviewListView(),
            ),
          ],
        )
    );
  }
  //댓글 보여줌
  Widget _ReviewListView() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      itemCount: _review.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: ListTile(
              title: Text(_review[index]),
              onTap:() {},
            )
        );
      },
      //separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,thickness: 2,)
    );
  }
}