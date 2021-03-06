import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/HomePages/FastFood.dart';
import 'package:newitem_alarm/HomePages/HomePage.dart';
import 'package:newitem_alarm/HomePages/SearchPage.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../GoodsPages/goodsDetail_New.dart';
import '../model/goods.dart';

class HomePage extends StatefulWidget {
  final Goods goods;

  const HomePage({Key key, @required this.goods}) : super(key: key);

  static String routeName = "/home";



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  String productName = "";
  CollectionReference goodsRef = FirebaseFirestore.instance.collection('Goods');

  Widget _newProductList() {
    return FutureBuilder<QuerySnapshot>(
        future: goodsRef.orderBy('launchdate', descending: false).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xfff1c40f))),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final List<QueryDocumentSnapshot<Object>> _newGoodsList =
              snapshot.data.docs;
          return ListView.builder(
              itemCount: _newGoodsList.length - 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _itemContainer(_newGoodsList[index].data(), index);
              });
        });
  }

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
                '????????? ??????',
                style: TextStyle(fontSize: 20),
              ),
            ),
            _newProductList()
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
                    child: Text('?????????????',
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
      {
        'icon': "assets/icons_new/icons8-chocolate-bar-96.png",
        "text": "??????/?????????"
      },
      {'icon': "assets/icons_new/icons8-bread-96.png", "text": "???"},
      {'icon': "assets/icons_new/icons8-energy-drink-96.png", "text": "??????"},
      {'icon': "assets/icons_new/icons8-cafe-96.png", "text": "??????/?????????"},
      {'icon': "assets/icons_new/icons8-beer-96.png", "text": "??????"},
      {'icon': "assets/icons_new/icons8-noodles-96.png", "text": "??????"},
      {'icon': "assets/icons_new/icons8-hamburger-96.png", "text": "?????????"},
      {'icon': "assets/icons_new/icons8-pizza-96.png", "text": "??????"},
      {'icon': "assets/icons_new/icons8-poultry-leg-96.png", "text": "??????"},
      {'icon': "assets/icons_new/icons8-cooker-96.png", "text": "??????/??????"},
      {
        'icon': "assets/icons_new/icons8-ice-pop-yellow-96.png",
        "text": "???????????????"
      },
      {'icon': "assets/icons_new/icons8-gingerbread-man-96.png", "text": "??????"}
    ];
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 5)), //?????????????????? ??????????????? ??? ??? ????????? ??????.
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
            MaterialPageRoute(builder: (context) => FastFood(changeName: label)),
          );
        },
        child: Column(
          children: [
            SimpleShadow(
              opacity: 0.8,
              sigma: 1,
              offset: Offset(4, 4),
              color: Colors.grey,
              child: Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(icons)))),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

/*
  Widget _itemList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: goodsList.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _itemContainer(index);
        });
  }*/

  Widget _itemContainer(var _item, index) {
    NewGoods _goods = NewGoods.fromJson(_item);
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
        //color: Colors.grey,
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          height: 300,
          child: Column(
            children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            //goodsDetail.dart??? ???????????????  Navigator push???.
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoodsDetailHome(
                                      goods: _goods,
                                    )));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image:
                                            NetworkImage(_goods.imageURL[0]))),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(2),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              color: Color(0xfff4ffff),
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                            ),
                            height: 86,
                            //color: Colors.white30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  /*child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.teal,
                                      ),
                                      child: Center(
                                        child: Text('Profile'),
                                      )),*/
                                ),
                                /*Padding(
                                  padding: EdgeInsets.all(5),
                                ),*/
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10.5),
                                    ),
                                    Container(
                                      width: 300,
                                      //color: Colors.red,
                                      child: Text(
                                        _goods.title,
                                        maxLines: 1,
                                        //overflow: TextOverflow.ellipsis,
                                        style: TextStyle(height: 1.0, fontSize: 17, letterSpacing: 1.2),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            _goods.price.toString(),
                                            style: TextStyle(height: 1.0, fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              " ???",
                                            style: TextStyle(height: 1.3, fontSize: 13),
                                          )
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TestProvider extends ChangeNotifier {
  void testFunction() {
    print('Provider test');
  }
}
