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
