import 'dart:typed_data';

import 'package:flutter/material.dart';

class FastFood extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<FastFood> {

  DateTime _selectedDate;

  Widget calendar() {
    if(_selectedDate == null) {
      return Text("");
    }
    else {
      return Text('$_selectedDate', style: TextStyle(fontSize: 20),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("패스트푸드"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () {
                  Future<DateTime> selected = showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2025),
                      //initialDatePickerMode: DatePickerMode.year,
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                            data: ThemeData.light(), // 달력 테마
                            child: child
                        );
                      }
                  );
                  selected.then((dateTime) {
                    setState(() {
                      _selectedDate = dateTime;
                    });
                  });
                },
              ),
              calendar(),
            ],
          )
        ],
      )
    );
  }

}
