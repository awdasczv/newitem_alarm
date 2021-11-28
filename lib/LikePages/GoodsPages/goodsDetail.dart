import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/goods.dart';

import '../GoodsPages/goodsDetail_Body.dart';

class DetailMain extends StatefulWidget {
  static String routeName = "/goodsDetail";
  // final Goods goods; //goods.dart에 있는 Goods 객체 넘겨받기
  // // const DetailMain({@required this.goods});

  @override
  _DetailMainState createState() => _DetailMainState();
}

class _DetailMainState extends State<DetailMain> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
            iconSize: 28,
            tooltip: 'Back Icon',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              icon: _icon(),
              iconSize: 35,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share_rounded),
              iconSize: 35,
            )
          ],
        ),
        body: ListView(
          children: [Top(goods: goodsList[0])],
        ));
  }
}
