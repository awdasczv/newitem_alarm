import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/GoodsPages/goodsDetail.dart';
import 'package:newitem_alarm/HomePages/FastFood.dart';
import 'package:newitem_alarm/HomePages/SearchPage.dart';
import 'package:newitem_alarm/model/Favorite_button.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

import '../model/Favorite_button.dart';
import '../model/goods.dart';

class HomePage extends StatefulWidget {
  final Goods goods;

  const HomePage({Key key, @required this.goods}) : super(key: key);

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

  List<bool> _isfavorite;
  final _colorList2 = [Colors.black54, Colors.black87];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isfavorite = List.filled(_colorList1.length, false);
  }

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        _banner(),
        _category(),
        Divider(
          thickness: 3,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            '이주의 신상',
            style: TextStyle(fontSize: 20),
          ),
        ),
        _itemList()
      ],
    ));
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
                ],
              ),
            ))
      ],
    );
  }

  Widget _category() {
    List<Map> category = [
      {'icon': "assets/icons/chocolate.png", "text": "젤리/초콜릿"},
      {'icon': "assets/icons/bread.png", "text": "빵집"},
      {'icon': "assets/icons/softdrink.png", "text": "음료"},
      {'icon': "assets/icons/cafe.png", "text": "카페/디저트"},
      {'icon': "assets/icons/alchol.png", "text": "주류"},
      {'icon': "assets/icons/ramen.png", "text": "라면"},
      {'icon': "assets/icons/burger.png", "text": "햄버거"},
      {'icon': "assets/icons/pizza.png", "text": "피자"},
      {'icon': "assets/icons/fried-chicken.png", "text": "치킨"},
      {'icon': "assets/icons/microwave.png", "text": "즉석/냉동"},
      {'icon': "assets/icons/ice-cream.png", "text": "아이스크림"},
      {'icon': "assets/icons/crisps.png", "text": "과자"}
    ];
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 5)), //카테고리라고 안써있어도 될 것 같아서 지움.
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(category[0]['icon'], category[0]['text']),
                _customButton(category[1]['icon'], category[1]['text']),
                _customButton(category[2]['icon'], category[2]['text']),
                _customButton(category[3]['icon'], category[3]['text']),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(category[4]['icon'], category[4]['text']),
                _customButton(category[5]['icon'], category[5]['text']),
                _customButton(category[6]['icon'], category[6]['text']),
                _customButton(category[7]['icon'], category[7]['text']),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _customButton(category[8]['icon'], category[8]['text']),
                _customButton(category[9]['icon'], category[9]['text']),
                _customButton(category[10]['icon'], category[10]['text']),
                _customButton(category[11]['icon'], category[11]['text']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButton(String icons, String label) {
    return Container(
      width: 60,
      child: InkWell(
        //splashColor: Colors.green,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FastFood()),
          );
        },
        child: Column(
          children: [
            Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xfff1c40f),
                    image:
                        DecorationImage(image: AssetImage(icons), scale: 16))),
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: goodsList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _itemContainer(index);
        });
  }

  Widget _itemContainer(int index) {
    Icon _icon() {
      if (_isfavorite[index]) {
        return Icon(
          Icons.favorite,
          color: Colors.redAccent,
        );
      } else
        return Icon(
          Icons.favorite_border,
        );
    }

    return Padding(
      padding: EdgeInsets.all(4),
      child: Card(
          child: Container(
            height: 300,
            child: Column(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            //goodsDetail.dart와 연결되도록  Navigator push함.
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailMain(
                                    goods: goodsList[index],
                                  )));
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                              goodsList[index].imageUrl1))),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: FavoriteButton(
                                    iconSize: 60,
                                    iconDisabledColor: Colors.black87,
                                    isFavorite: false,
                                    valueChanged: (_isFavorite) {
                                      print('Is Favorite : $_isFavorite');
                                    },
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
                                        goodsList[index].title,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      Text(
                                        goodsList[index].price.toString() + "원",
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
          )
      )
    );
  }
}

class TestProvider extends ChangeNotifier {
  void testFunction() {
    print('Provider test');
  }
}
