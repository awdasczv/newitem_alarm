import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/EditComment.dart';
import 'package:newitem_alarm/ProfilePages/MyComment.dart';

class CommandMan extends StatefulWidget {
  @override
  _CommandManState createState() => _CommandManState();
}

class _CommandManState extends State<CommandMan> {
  List<String> _comment = [
    "댓글: 나쁘지 않은듯 함",
    "댓글: 좋아요",
    "댓글: 이건 아닌듯",
    "댓글: 완전 공감됨",
    "댓글:존나 웃겨"
  ];

  bool commentEditButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("댓글 관리",
              style: TextStyle(fontSize: 20, color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
        ),
        body: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "내가 쓴 댓글",
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffFFC845),
                        onPrimary: Colors.black,
                      ),
                      onPressed: () async {
                        var a = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditComment(comment: _comment)),
                        );
                        if (a != null) {
                          for (int i = 0; i < _comment.length; i++) {
                            if (a[i] == true) {
                              _comment[i] = "";
                            }
                          }
                          _comment.removeWhere((_comment) => _comment == "");
                        }
                        setState(() {
                          commentEditButton = true;
                        });
                      },
                      child: Text(" 편집"),
                    ),
                  ],
                )),
            Expanded(
              child: _CommentListView(),
            ),
          ],
        )));
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
          onTap: () {
            String aComment = _comment[index];
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyComment(myComment: aComment)),
            );
          },
        ));
      },
      //separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,thickness: 2,)
    );
  }
}
