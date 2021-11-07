import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../LikePages/GoodsPages/goodsDetail_Body.dart';
import '../../model/goods.dart';

class DetailMain extends StatefulWidget {
  static String routeName = "/goodsDetail";
  final Goods goods; //goods.dart에 있는 Goods 객체 넘겨받기
  const DetailMain({Key key, @required this.goods}) : super(key: key);

  @override
  _DetailMainState createState() => _DetailMainState();
}

class _DetailMainState extends State<DetailMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Body(goods: goodsList[0]));
  }
}
