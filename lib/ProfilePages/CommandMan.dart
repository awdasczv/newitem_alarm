import 'package:flutter/material.dart';

class CommandMan extends StatefulWidget {

  @override
  _CommandManState createState() => _CommandManState();
}

class _CommandManState extends State<CommandMan> {

  var _isChecked1 = false;
  var _isChecked2 = false;
  var _isChecked3 = false;
  var _isChecked4 = false;
  var _isChecked5 = false;


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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
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
                            onPressed: (){},//edit,
                            child: Text("편집"),
                          )
                      )
                    ],
                  )
              ),

              //댓글 내용
              Padding(
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
                      Checkbox(
                        value: _isChecked1,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked1 = value;
                          });
                        },
                      )
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
                      Checkbox(
                        value: _isChecked2,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked2 = value;
                          });
                        },
                      )
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
                      Checkbox(
                        value: _isChecked3,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked3 = value;
                          });
                        },
                      )
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
                      Checkbox(
                        value: _isChecked4,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked4 = value;
                          });
                        },
                      )
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
                      Checkbox(
                        value: _isChecked5,
                        onChanged:  (value) {
                          setState(() {
                            _isChecked5 = value;
                          });
                        },
                      )
                    ],
                  )
              ),
            ],
          )
        )
      )
    );
  }

}