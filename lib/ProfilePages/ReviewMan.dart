import 'package:flutter/material.dart';

class ReviewMan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("리뷰 관리",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
    );
  }
}