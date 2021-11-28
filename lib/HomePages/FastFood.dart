import 'dart:typed_data';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:flutter/material.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class FastFood extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<FastFood> {

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

  DateTime _selectedDate;

  //PageController _controller = PageController();

  Widget calendar() {
    if (_selectedDate == null) {
      return Text("");
    }
    else {
      return Text('$_selectedDate', style: TextStyle(fontSize: 20),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView( // 한 화면에 여러 개의 스크롤 사용 가능
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Row(
                    children: [
                      Text("패스트푸드"),
                      _Calendar()
                    ],
                  ),
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
                      return Container();
                    },
                    childCount: 20,
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Expanded(child: _itemList()),
              ],
            )
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
        Stack(
            children: [
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
            ]
        ),
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
                        )
                    )
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("상품이름 가나다라", style: TextStyle(fontSize:17),),
                    Text("가격 2800원", style: TextStyle(fontSize: 17),)
                  ],
                )
              ],
            )
        )
      ],
    );
      /*Container(
      height: 300,
      child: Column(
        children: [
          Stack(
              children: [
                Container(
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
              ]
          ),
          /*Container(
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
                          )
                      )
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("상품이름 가나다라", style: TextStyle(fontSize:17),),
                      Text("가격 2800원", style: TextStyle(fontSize: 17),)
                    ],
                  )
                ],
              )
          ),*/
        ],
      ),
    );*/
  }

  Widget _ScrollPage() {
    return ScrollingPageIndicator(
      dotColor: Colors.grey,
      dotSelectedColor: Colors.blue,
      dotSize: 10,
      dotSelectedSize: 12,
      dotSpacing: 20,
      controller: _pageController,
      itemCount: 3,
      orientation: Axis.horizontal,
    );
  }

  Widget _Sliver() {
    return CustomScrollView(
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
    );
  }
}
