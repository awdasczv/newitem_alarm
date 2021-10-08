import 'package:flutter/material.dart';
import 'package:newitem_alarm/ProfilePages/EditComment.dart';
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

  bool editButton = false;


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
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => EditComment(comment: _comment)),
                          );
                          setState(() {
                            editButton = true;
                          });
                        },
                        child: Text(" 편집"),
                    )
                )
              ],
            )
        ),
        Expanded(
          child: _ListView(),
        ),
      ],
    )
    );
  }
  //댓글 보여줌
  Widget _ListView() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      itemCount: _comment.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(_comment[index]),
            onTap:() {},
          )
        );
      },
      //separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,thickness: 2,)
    );
  }
  /*
  Widget _delete() {
    setState(() {
      Text(" 삭제");
      Checkbox(
        value: _isChecked1,
        onChanged:  (value) {
          setState(() {
            _isChecked1 = value;
          });
        },
      );
      setState(() {
        if(_isChecked1 = true) {
          Dismissible(
            key: Key(_comment[0]),
            onDismissed: (direction) {
              setState(() {
                _comment.removeAt(0);
              });
            },
          );
        }
      });
    });
    return _delete();
  }
   */
}