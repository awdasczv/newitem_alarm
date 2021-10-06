import 'package:flutter/material.dart';

class CommandMan extends StatefulWidget {

  @override
  _CommandManState createState() => _CommandManState();
}

class _CommandManState extends State<CommandMan> {

  List<String> _comment = [
    "댓글@@@@@@@@@@@@@@@@@@@@",
    "댓글@@@@@@@@@@@@@@@@@@@@",
    "댓글@@@@@@@@@@@@@@@@@@@@",
    "댓글@@@@@@@@@@@@@@@@@@@@",
    "댓글@@@@@@@@@@@@@@@@@@@@"
  ];

  var _isChecked1 = false;
  var _isChecked2 = false;
  var _isChecked3 = false;
  var _isChecked4 = false;
  var _isChecked5 = false;

  bool visible = false;

  void _delete() {
    setState(() {
      Text(" 삭제");
      if(_isChecked1 = true) {

      }
    });
  }


  /*void edit() {
    setState(() {
      Checkbox(
        value: _isChecked,
        onChanged:  (value) {
          setState(() {
            _isChecked = value;
          });
        },
      );
    });
  }*/

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
                        onPressed: () {
                          Text(" 편집");
                          setState(() {
                            visible = true;
                          });
                        },
                        // 편집을 누르면 편집 버튼이 삭제로 변경
                        child: visible == true ? Text(" 삭제") : Text(" 편집")
                    )
                )
              ],
            )
        ),
        Expanded(
          child: _ListView(),
        ),
        //댓글 내용
        /*Padding(
                  padding: EdgeInsets.fromLTRB(5, 40, 5, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.fromLTRB(2, 25, 2, 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("리뷰 관리 @@@@@@@@@@@@@@@@@@@@@@@@2",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left ),

                              ],
                            )
                        ),
                      ),
                      // 편집을 누르면 체크박스 활성화
                      visible == true ? Checkbox(
                        value: _isChecked1,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked1 = value;
                          });
                        },
                      ) : Text("")
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.fromLTRB(2, 25, 2, 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("리뷰 관리 @@@@@@@@@@@@@@@@@@@@@@@@2",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left ),

                              ],
                            )
                        ),
                      ),
                      visible == true ? Checkbox(
                        value: _isChecked2,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked2 = value;
                          });
                        },
                      ) : Text("")
                    ],
                  )
              ),

              Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.fromLTRB(2, 25, 2, 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("리뷰 관리 @@@@@@@@@@@@@@@@@@@@@@@@2",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left ),

                              ],
                            )
                        ),
                      ),
                      visible == true ? Checkbox(
                        value: _isChecked3,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked3 = value;
                          });
                        },
                      ) : Text("")
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.fromLTRB(2, 25, 2, 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("리뷰 관리 @@@@@@@@@@@@@@@@@@@@@@@@2",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left ),

                              ],
                            )
                        ),
                      ),
                      visible == true ? Checkbox(
                        value: _isChecked4,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked4 = value;
                          });
                        },
                      ) : Text("")
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.fromLTRB(2, 25, 2, 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("리뷰 관리 @@@@@@@@@@@@@@@@@@@@@@@@2",
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left ),

                              ],
                            )
                        ),
                      ),
                      visible == true ? Checkbox(
                        value: _isChecked5,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked5 = value;
                          });
                        },
                      ) : Text("")
                    ],
                  )
              ),*/
      ],
    )
    );
  }
  Widget _ListView() {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      itemCount: _comment.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_comment[index], style: TextStyle( fontSize: 23),),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,thickness: 2,)
    );
  }
}