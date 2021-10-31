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
          title: Text("전체 목록 편집",
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
                      Checkbox(
                        value: commentAllCheck,
                        onChanged: (value) {
                          setState(() {
                            if (commentAllCheck = value) {
                              _commentCheckBox = List<bool>.filled(widget.comment.length, true);
                            }
                          });
                        },
                      ),
                      Text(
                        "전체 선택",
                        style: TextStyle(fontSize: 28),
                      ),
                    ],
                  )
              ),
              Expanded(
                child: _CommentEditList(),
              ),
              GestureDetector(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(140, 0, 140, 0),
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text("선택한 항목 삭제",maxLines: 80, style: TextStyle(fontSize: 20, color: Colors.black,))
                          )
                        ],
                      )
                    //child: Text("선택한 항목 삭제", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                  onTap: () {
                    _CommentDeleteDialog();
                  }
              )
            ]
        )
    );
  }

  /* Widget _EditList() {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        itemCount: widget.comment.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: CheckboxListTile(
                title: Text(widget.comment[index]),
                value: _checkBox[index],
                onChanged: (value) {
                  setState(() {
                    _checkBox[index] = value;
                    print(index);
                  });
                },
              )
          );
        }
    );
  }
  */
  /*Widget _EditList() {
    return ListView.builder(
      itemCount: widget.comment.length,
      itemBuilder: (context, index) {
        final item = widget.comment[index];
        return Dismissible(
          key: Key(item),
          //direction: DismissDirection.startToEnd,
          child: CheckboxListTile(
            title: Text(item),
            value: _checkBox[index],
            onChanged: (value) {
              setState(() {
                _checkBox[index] = value;


                //widget.comment.removeAt(index);
              });
            },
            /*
            trailing: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                setState(() {
                  widget.comment.removeAt(index);
                });
              },
            ),
            */
          ),
          onDismissed: (direction) {
            setState(() {
              widget.comment.removeAt(index);
            });
          },
        );
      },
    );
  }*/
  Widget _CommentEditList() {
    return ListView.builder(
      itemCount: widget.comment.length,
      itemBuilder: (context, index) {
        final item = widget.comment[index];
        return CheckboxListTile(
          title: Text(item),
          controlAffinity: ListTileControlAffinity.leading,
          value: _commentCheckBox[index],
          onChanged: (value) {
            setState(() {
              _commentCheckBox[index] = value;
              /*if(_commentCheckBox[index] = false) {
                commentAllCheck = false;
              }*/
            });
          },
        );
      },
    );
  }
/*
  Widget _delete() {
    setState(() {
      if( = true) {

      }
      widget.comment.remove(widget.comment);
    });
  }
*/
  Future _CommentDeleteDialog() async{              //선택 항목 삭제 팝업
    var a = await showDialog(
        context: context,
        barrierDismissible: false, //바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(                //팝업창 모서리 둥글게
                borderRadius: BorderRadius.circular(8.0),
              ),
              //title: new Text("", style: TextStyle(fontWeight: FontWeight.bold),),
              content: SingleChildScrollView(
                child: ListBody(
                    children: [
                      Text("선택 항목을 삭제 하시겠습니까?", style: TextStyle(fontWeight: FontWeight.bold),),
                    ]
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  child: Text("삭제", style: TextStyle(fontWeight: FontWeight.bold), ),
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
                  child: Text("아니오", style: TextStyle(fontWeight: FontWeight.bold), ),
                  onPressed:() {
                    //widget.comment.removeAt(index)
                    Navigator.pop(context, 2);
                  },
                )
              ]
          );
        }
    );
    if(a == 1) {
      Navigator.pop(context, _commentCheckBox);
    }
  }
}