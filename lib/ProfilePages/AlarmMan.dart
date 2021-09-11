import 'package:flutter/material.dart';

class AlarmMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알림 설정",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}