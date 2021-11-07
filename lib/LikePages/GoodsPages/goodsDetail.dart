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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Body(
            goods: goodsList[0],
          ),
        ));
  }
}
