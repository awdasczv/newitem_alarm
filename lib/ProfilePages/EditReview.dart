import 'package:flutter/material.dart';

class EditReview extends StatefulWidget {
  final List<String> review;

  const EditReview({Key key, this.review}) : super(key: key);
  @override
  _EditReviewState createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {

  List<bool> _reviewCheckBox = [];

  bool reviewAllCheck = false;

  void initState() {
    super.initState();
    _reviewCheckBox = List<bool>.filled(widget.review.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("전체 목록 편집",
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
                      Checkbox(
                        value: reviewAllCheck,
                        onChanged: (value) {
                          setState(() {
                            if (reviewAllCheck = value) {
                              _reviewCheckBox = List<bool>.filled(widget.review.length, true);
                            }
                            else {
                              _reviewCheckBox = List<bool>.filled(widget.review.length, false);
                            }
                          });
                        },
                      ),
                      Text(
                        "전체 선택",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )
              ),
              Expanded(
                child: _ReviewEditList(),
              ),
              GestureDetector(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(140, 0, 140, 0),
                      color: Colors.blue,
                      child: FittedBox(
                          child: Text("선택한 항목 삭제",maxLines: 80, style: TextStyle(fontSize: 20, color: Colors.black,))
                      )
                    //child: Text("선택한 항목 삭제", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                  onTap: () {
                    _ReviewDeleteDialog();
                  }
              )
            ]
        )
    );
  }

  Widget _ReviewEditList() {
    return ListView.builder(
      itemCount: widget.review.length,
      itemBuilder: (context, index) {
        final item = widget.review[index];
        return CheckboxListTile(
          title: Text(item),
          controlAffinity: ListTileControlAffinity.leading,
          value: _reviewCheckBox[index],
          onChanged: (value) {
            setState(() {
              _reviewCheckBox[index] = value;
              List<bool> _temp = _reviewCheckBox.where((element) => element == false).toList();

              if(!value) {
                reviewAllCheck = false;
              }
              if(_temp.length == 0) {
                reviewAllCheck = true;
              }
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
  Future _ReviewDeleteDialog() async{              //선택 항목 삭제 팝업
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
                  onPressed:() {
                    //widget.comment.removeAt(index);
                    Navigator.pop(context, 1);
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
                    Navigator.pop(context, 2);
                  },
                )
              ]
          );
        }
    );
    if(a == 1) {
      Navigator.pop(context, _reviewCheckBox);
    }
  }
}