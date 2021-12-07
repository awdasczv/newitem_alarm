import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final idController = TextEditingController();
  final pwController = TextEditingController();

  String _id = "";
  String _pw = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
      ),
      body: Column(
        children: [
          Id(),
          /*Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: Row(
                children: <Widget>[

                  /*focusNode.hasFocus
                      ? Expanded(
                    child: GestureDetector(
                      child: Center(child: Text('취소', style: TextStyle(fontSize: 15, color: Colors.black),),),
                      onTap: () {
                        setState(() {
                          _filter.clear();
                          _searchText = "";
                          focusNode.unfocus();
                        });
                      },
                    ),
                  ) : Expanded(flex: 0, child: Container(),)*/
                ],
              )
          ),*/
        ],
      )
    );
  }

  Widget Id() {
    return Expanded(
      flex: 6,
      child: TextField(
        style: TextStyle(fontSize: 15),
        autofocus: true,
        controller: idController,
        /*decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white12,
          prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
          suffixIcon: focusNode.hasFocus
              ? IconButton(
            icon: Icon(
              Icons.cancel, color: Colors.grey, size: 20,
            ),
            onPressed: () {
              setState(() {
                _filter.clear();
                _searchText = "";
              });
            },
          )
              : Container(),   // 커서가 있을 때 cancel 버튼을 띄우고, 아니라면 빈 상태로 보여준다.
          hintText: '검색',
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ), // foucusBorder 투명하게 설정
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),*/
      ),
    );
  }
}
