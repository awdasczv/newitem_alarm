import 'package:flutter/material.dart';

class EditComment extends StatefulWidget {
  final List<String> comment;

  const EditComment({Key key, this.comment}) : super(key: key);
  @override
  _EditCommentState createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {

  List<bool> _checkBox = [];

  bool allCheck = false;

  void initState() {
    super.initState();
    _checkBox = List<bool>.filled(widget.comment.length, false);
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
                        value: allCheck,
                        onChanged: (value) {
                          setState(() {
                            allCheck = value;
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
                child: _EditList(),
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
                    _deleteDialog();
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
  Widget _EditList() {
    return ListView.builder(
      itemCount: widget.comment.length,
      itemBuilder: (context, index) {
        final item = widget.comment[index];
        return CheckboxListTile(
          title: Text(item),
          value: _checkBox[index],
          onChanged: (value) {
            setState(() {
              _checkBox[index] = value;
            });
          },
        );
      },
    );
  }
/*
  Widget _delete() {
    setState(() {
      if( = false) {

      }
      widget.comment.removeAt(index);
    });
  }
*/
  Widget _deleteDialog() {              //선택 항목 삭제 팝업
    showDialog(
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
                onPressed:() {
                  //widget.comment.removeAt(index)
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text("아니오", style: TextStyle(fontWeight: FontWeight.bold), ),
                onPressed:() {
                  //widget.comment.removeAt(index)
                  Navigator.of(context).pop();
                },
              )
            ]
          );
        }
    );
  }
}