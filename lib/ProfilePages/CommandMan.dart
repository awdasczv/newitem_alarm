import 'package:flutter/material.dart';

class CommandMan extends StatefulWidget {
  @override
  _CommandManState createState() => _CommandManState();
}

class _CommandManState extends State<CommandMan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: () {},
                        child: Text("편집"),
                      )
                  )
                ],
              )
          )
        ],
      )
    );
  }

}

/*
class CommandMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("댓글 관리",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}*/
