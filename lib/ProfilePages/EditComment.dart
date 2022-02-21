import 'package:flutter/material.dart';

class EditComment extends StatefulWidget {
  final List<String> comment;

  const EditComment({Key key, this.comment}) : super(key: key);
  @override
  _EditCommentState createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  int index;

  List<bool> _commentCheckBox = [];

  bool commentAllCheck = false;

  void initState() {
    super.initState();
    _commentCheckBox = List<bool>.filled(widget.comment.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "전체 목록 편집",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: commentAllCheck,
                    onChanged: (value) {
                      setState(() {
                        if (commentAllCheck = value) {
                          _commentCheckBox =
                              List<bool>.filled(widget.comment.length, true);
                        } else {
                          _commentCheckBox =
                              List<bool>.filled(widget.comment.length, false);
                        }
                      });
                    },
                  ),
                  Text(
                    "전체 선택",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )),
          Expanded(
            child: _CommentEditList(),
          ),
          GestureDetector(
              child: Card(
                child: Container(
                    padding: EdgeInsets.fromLTRB(140, 20, 140, 20),
                    color: Color(0xffFFC845),
                    child: FittedBox(
                      //fit: BoxFit.contain,
                      child: Text("선택한 항목 삭제",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.black,
                          )),
                    )
                    //child: Text("선택한 항목 삭제", style: TextStyle(fontSize: 20, color: Colors.white),),
                    ),
              ),
              onTap: () {
                _CommentDeleteDialog();
              })
        ]));
  }

  Widget _CommentEditList() {
    return ListView.builder(
      itemCount: widget.comment.length,
      itemBuilder: (context, index) {
        final item = widget.comment[index];
        return Card(
          child: CheckboxListTile(
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            value: _commentCheckBox[index],
            onChanged: (value) {
              setState(() {
                _commentCheckBox[index] = value;
                List<bool> _temp = _commentCheckBox
                    .where((element) => element == false)
                    .toList();

                if (!value) {
                  commentAllCheck = false;
                }
                if (_temp.length == 0) {
                  commentAllCheck = true;
                }
              });
            },
          ),
        );
      },
    );
  }

  Future _CommentDeleteDialog() async {
    //선택 항목 삭제 팝업
    var a = await showDialog(
        context: context,
        barrierDismissible: false, //바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                //팝업창 모서리 둥글게
                borderRadius: BorderRadius.circular(8.0),
              ),
              //title: new Text("", style: TextStyle(fontWeight: FontWeight.bold),),
              content: SingleChildScrollView(
                child: ListBody(children: [
                  Text(
                    "선택 항목을 삭제 하시겠습니까?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  child: Text(
                    "삭제",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },

                  /*onPressed:() async {
                    //widget.comment.removeAt(index);
                    var a = await Navigator.pop(context, _commentCheckBox);
                    if(a=yes) {
                      widget.comment.removeAt(index);
                      Navigator.pop(context, _commentCheckBox);
                    }
                  },*/
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  child: Text(
                    "아니오",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    //widget.comment.removeAt(index)
                    Navigator.pop(context, 2);
                  },
                )
              ]);
        });
    if (a == 1) {
      Navigator.pop(context, _commentCheckBox);
    }
  }
}
