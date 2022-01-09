import 'package:flutter/material.dart';
import 'package:newitem_alarm/HomePages/Calendar_timeline.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

import './Calendar_timeline.dart';

class FastFood extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<FastFood> {
  DateTime _selectedDateTime = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  String text = '';

  List yearList = ["2021년", "2020년", "2019년"];

  List monthList = [
    "12월",
    "11월",
    "10월",
    "09월",
    "08월",
    "07월",
    "06월",
    "05월",
    "04월",
    "03월",
    "02월",
    "01월"
  ];

  final _colorList1 = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.red,
    Colors.amber,
    Colors.brown,
    Colors.yellow,
  ];
  final _colorList2 = [Colors.teal, Colors.black87];

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  String year;
  String month;


 @override
 void initState(){
   super.initState();

   year = DateTime.now().year.toString();
   month = DateTime.now().month.toString();
 }


  Widget _selectYear() {
    for (int i = 0; i < yearList.length; i++) {
      Text(yearList[i]);
    }
  }

  //PageController _controller = PageController();


  Widget calendar() {
    if (_selectedDate == null) {
      return Text("");
    } else {
      return Text(
        '$_selectedDateTime',
        style: TextStyle(fontSize: 20),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            // 한 화면에 여러 개의 스크롤 사용 가능
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  expandedHeight: 170,
                  bottom: PreferredSize(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Calendar(),
                    ),
                    preferredSize: Size.fromHeight(110),
                  ),
                  centerTitle: true,
                  title: Text(
                    "패스트푸드",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  floating: true,
                  snap: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.black,
                      size: 23,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container();
                    },
                    childCount: 20,
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                //_selectDate(),
                Expanded(child: _itemList()),
              ],
            )));
  }


  // Widget _Calendar() {
  //   return Row(
  //     children: [
  //       IconButton(
  //         icon: Icon(Icons.date_range),
  //         onPressed: () {
  //           Future<DateTime> selected = showDatePicker(
  //               context: context,
  //               initialDate: DateTime.now(),
  //               firstDate: DateTime(2015),
  //               lastDate: DateTime(2025),
  //               //initialDatePickerMode: DatePickerMode.year,
  //               builder: (BuildContext context, Widget child) {
  //                 return Theme(
  //                     data: ThemeData.light(), // 달력 테마
  //                     child: child
  //                 );
  //               }
  //           );
  //           selected.then((dateTime) {
  //             setState(() {
  //               _selectedDate = dateTime;
  //             });
  //           });
  //         },
  //       ),
  //       calendar(),
  //     ],
  //   );
  // }


  /*Widget _Calendar() {
    return Container(
        child: Row(
      children: [
        ElevatedButton(
            child: Text('--년 --월'),
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false, // 바깥 영역 터치시 닫을지 여부
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Column(
                        children: [Text("날짜 선택")],
                      ),
                      content: SingleChildScrollView(
                          child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 500,
                            color: Colors.red,
                            child: Center(
                              child: Text(
                                "2021년",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          )
                        ],
                      )),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text("ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text("cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }),
      ],
    ));
  }
*/
  Widget _itemList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _colorList1.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            _Swipe(index),
          ],
        );
      },
    );
  }

  Widget _Swipe(int index) {
    return Column(
      children: [
        Stack(children: [
          Container(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: _colorList2[_currentPageNotifier.value % 2],
                  child: Center(
                    child: FlutterLogo(
                      textColor: _colorList1[index % _colorList1.length],
                      size: 100,
                      style: FlutterLogoStyle.stacked,
                    ),
                  ),
                );
              },
              onPageChanged: (int index) {
                _currentPageNotifier.value = index % _colorList1.length;
              },
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CirclePageIndicator(
                itemCount: _colorList1.length,
                currentPageNotifier: _currentPageNotifier,
              ),
            ),
          ),
        ]),
        Container(
            height: 70,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal,
                        ),
                        child: Center(
                          child: Text("Logo"),
                        ))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "상품이름 가나다라",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "가격 2800원",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
// Widget _Calendar() {
//   final String formattedDate = DateFormat.yMMM().format(_selectedDateTime);
//   final selectedText = Text('$formattedDate');
//
//   return Material(
//     color: Colors.transparent,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         //const Text('month', //style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 15),),
//         const Padding(
//           padding: EdgeInsets.only(bottom: 5.0),
//         ),
//         CupertinoDateTextBox(
//        //     initialValue: _selectedDateTime,
//             onDateChange: _Month,
//             hintText: DateFormat.yMMM().format(_selectedDateTime),
//
//         ),
//       ],
//     ),
//   );
// }
}
