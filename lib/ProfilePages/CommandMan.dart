import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/EditComment.dart';
import 'package:newitem_alarm/ProfilePages/MyComment.dart';

class CommandMan extends StatefulWidget {

  @override
  _CommandManState createState() => _CommandManState();
}

class _CommandManState extends State<CommandMan> {

  List<String> _comment = [
    "댓글11111111111111111111111111111111111111",
    "댓글22222222222222222222222222222222222222222222222",
    "댓글3333333333333333333333333333333333333",
    "댓글44444444444444444444444444444444444444444444444444444",
    "댓글5555555555555555555555555555555"
  ];

  bool commentEditButton = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("댓글 관리",
            style: TextStyle(fontSize: 20),),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)
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
                    Text("내가 쓴 댓글", style: TextStyle(fontSize: 28),),
                    Padding(
                        padding: EdgeInsets.only(left: 155),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white10,
                            onPrimary: Colors.black,
                          ),
                          onPressed: () async {
                            var a = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditComment(comment: _comment)),
                            );
                            if(a != null) {
                              for(int i = 0; i < _comment.length; i++) {
                                if (a[i] == true) {
                                  _comment[i] = "";
                                }
                              }
                              _comment.removeWhere((_comment)=>_comment == "");
                            }
                            setState(() {
                              commentEditButton = true;
                            });
                          },
                          child: Text(" 편집"),
                        )
                    )
                  ],
                )
            ),
            Expanded(
              child: _CommentListView(),
            ),
          ],
        )
    );
  }
  //댓글 보여줌
  Widget _CommentListView() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      itemCount: _comment.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: Icon(Icons.person),
              ),
              title: Text(_comment[index]),
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyComment(firstComment: _comment)),
                );
              },
            )
        );
      },
      //separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,thickness: 2,)
    );
  }
}