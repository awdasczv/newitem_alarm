import 'package:flutter/material.dart';

class Manual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("이용약관",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}