import 'package:flutter/material.dart';
import 'package:newitem_alarm/GoodsPages/bar_chart.dart';

class Manual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("이용약관",
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
    );
  }
}