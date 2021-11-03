import 'package:flutter/material.dart';


class MyComment extends StatefulWidget {
  final List<String> firstComment;

  const MyComment({Key key, this.firstComment}) : super(key: key);
  @override
  _MyCommentState createState() => _MyCommentState();
}



class _MyCommentState extends State<MyComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("댓글 제목",
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
        children: [
          Expanded(
            child: _FirstComment(),
          )
        ],
      )
    );
  }
  Widget _FirstComment() {
    return Container(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: Icon(Icons.person),
              ),
              title: Text(widget.firstComment[0]),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(30, 30, 10, 30),
                  child: Icon(Icons.subdirectory_arrow_right_rounded)
                ),
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person, /*size:*/),
                    ),
                    title: Text(widget.firstComment[0]),
                  ),
                )
              ],
            )
          ],
        )
    );
  }
}
