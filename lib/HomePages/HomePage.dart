import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int index){
                    return  Container(
                      color: _colorList2[_currentPageNotifier.value%2],
                      child: Center(
                        child: FlutterLogo(
                          textColor: _colorList1[index % _colorList1.length],
                          size: 100,
                          style: FlutterLogoStyle.stacked,
                        ),
                      ),
                    );
                  },
                  onPageChanged: (int index){
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
              Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){},child: Text('먹어봤니',style: TextStyle(fontSize: 20,color: Colors.white)),),
                        IconButton(icon: Icon(Icons.search), onPressed: (){},iconSize: 30,color: Colors.white,)
                      ],
                    ),
                  )
              )
            ],
          ),
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text('카테고리', style: TextStyle(fontSize: 20),),
          ),
          Table(
            children: [
              TableRow(
                children: [
                  IconButton(icon: Icon(Icons.lunch_dining), onPressed: (){})
                ]
              )
            ],
          )
        ],
      )
    );
  }
}

class TestProvider extends ChangeNotifier{
  void testFunction(){
    print('Provider test');
  }
}
