import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class FastFood extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<FastFood> {

  DateTime _selectedDate;

  PageController _controller = PageController();

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
        title: Text('패스트푸드'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
          ),
          iconSize: 28,
          tooltip: 'Back Icon',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          _Calendar(),
          _Swipe(),
          _ScrollPage()
        ],
      )
    );
  }
  Widget _Calendar() {
    return Row(
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
    );
  }
  Widget _Swipe() {
    return AspectRatio(
      aspectRatio: 1,
      child: PageView(
        controller: _controller,
        children: [
          Container(
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.red,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                color: Colors.white
              )
            )
          ),
          Container(
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.green,
                child:  Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  color:  Colors.white,
                ),
              )
          ),
          Container(
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.blue,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  color:  Colors.white,
                ),
              )
          )
        ],
      )
    );
  }
  Widget _ScrollPage() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      color: Colors.white,
      child: ScrollingPageIndicator(
        dotColor: Colors.grey,
        dotSelectedColor: Colors.blue,
        dotSize: 10,
        dotSelectedSize: 12,
        dotSpacing: 20,
        controller: _controller,
        itemCount: 3,
        orientation: Axis.horizontal,
      ),
    );
  }
  /*Widget Sliver() {
    body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("패스트푸드"),
            centerTitle: true,
            floating: true,
            snap: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_sharp,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return GestureDetector(
                  child: Container(
                      height: 50.0,
                      color: Colors.orange,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        color: Colors.blueGrey,
                      )
                  ),
                  /*onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NoticeList()),
                        );
                      },*/
                );
              },
              childCount: 20,
            ),
          )
        ]
    ),
  }*/
}
