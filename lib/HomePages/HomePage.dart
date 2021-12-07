import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/LikePages/GoodsPages/goodsDetail.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:newitem_alarm/HomePages/SearchPage.dart';
import 'package:newitem_alarm/HomePages/FastFood.dart';
//import 'package:newitem_alarm/routes.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _colorList1 = [
    Color(0xffaee4ff),
    Color(0xffffe4af),
    Color(0xffafffba),
    Color(0xfffcc6f7),
    Color(0xffffafb0),
    Color(0xfff2cfa5),
    Color(0xffb5c7ed),
    Color(0xfffcffb0),
  ];
  final _colorList2 = [Colors.teal, Colors.black87];

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              _banner(),
              _category(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '이주의 신상',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              _itemList()
            ],
          )),
      //routes: route,
    );
  }

  Widget _banner() {
    return Stack(
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
        Positioned(
            left: 0.0,
            right: 0.0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('먹어봤니?',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                    iconSize: 30,
                    color: Colors.white,
                  )
                  /*
                  GestureDetector(
                child: Container(
                  color: Colors.orangeAccent,
                  padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, color: Colors.white,),
                      Text(" 프로필 수정하기", style: TextStyle(fontSize: 25, color: Colors.white), )
                    ],
                  )
                ),
                  onTap: () async{
                    var a = await
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeProfile(imagePath: _imagePath)),
                    );
                    setState(() {
                      _imagePath = a[0];
                      _name = a[1];
                    });
                  }
              ),
                  */
                ],
              ),
            ))
      ],
    );
  }

  Widget _category() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '카테고리',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(Icons.lunch_dining, '패스트푸드1'),
                _customButton(Icons.lunch_dining, '패스트푸드2'),
                _customButton(Icons.lunch_dining, '패스트푸드3'),
                _customButton(Icons.lunch_dining, '패스트푸드4'),
                _customButton(Icons.lunch_dining, '패스트푸드5'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(Icons.lunch_dining, '패스트푸드6'),
                _customButton(Icons.lunch_dining, '패스트푸드7'),
                _customButton(Icons.lunch_dining, '패스트푸드8'),
                _customButton(Icons.lunch_dining, '패스트푸드9'),
                _customButton(Icons.lunch_dining, '패스트푸드10'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(Icons.lunch_dining, '패스트푸드11'),
                _customButton(Icons.lunch_dining, '패스트푸드12'),
                _customButton(Icons.lunch_dining, '패스트푸드13'),
                _customButton(Icons.lunch_dining, '패스트푸드14'),
                _customButton(Icons.lunch_dining, '패스트푸드15'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(Icons.lunch_dining, '패스트푸드16'),
                _customButton(Icons.lunch_dining, '패스트푸드17'),
                _customButton(Icons.lunch_dining, '패스트푸드18'),
                _customButton(Icons.lunch_dining, '패스트푸드19'),
                _customButton(Icons.lunch_dining, '패스트푸드20'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButton(IconData icons, String label) {
    return Container(
      width: 60,
      child: InkWell(
        //splashColor: Colors.green,
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => FastFood()),);
        },
        child: Column(
          children: [
            Icon(
              icons,
              size: 40,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _colorList1.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _itemContainer(index);
        });
  }

  Widget _itemContainer(int index) {
    bool _isFavorite = false;

    Icon _icon() {
      if (_isFavorite) {
        return Icon(
          Icons.favorite,
          color: Colors.redAccent,
        );
      } else
        return Icon(
          Icons.favorite_border,
        );
    }

    return Container(
      height: 300,
      child: Column(
        children: [
          Expanded(
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      //goodsDetail.dart와 연결되도록  Navigator push함.
                      context,
                      DetailMain.routeName,
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 230,
                            color: _colorList1[index],
                            child: Center(
                              child: FlutterLogo(
                                size: 100,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            child: IconButton(
                              icon: _icon(),
                              iconSize: 40,
                              onPressed: () {
                                _isFavorite = !_isFavorite;
///////////////////////////////////////////////////////////////////////////////////
//오류부분 setstate가 작동이 안됨(아마 state가 반영되지 않는 위젯이라 그런 것 아닐까 의심..)
                                setState(() {});
                                print(_isFavorite);
                              },
///////////////////////////////////////////////////////////////////////////////////
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 70,
                        color: Colors.white30,
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
                                    child: Text('Profile'),
                                  )),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '상품이름 가나다라',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  '가격 28000원',
                                  style: TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}

class TestProvider extends ChangeNotifier {
  void testFunction() {
    print('Provider test');
  }
}
