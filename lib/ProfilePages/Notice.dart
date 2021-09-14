import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("공지사항",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}