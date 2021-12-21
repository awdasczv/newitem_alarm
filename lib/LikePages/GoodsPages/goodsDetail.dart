import 'package:favorite_button/favorite_button.dart';
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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
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
          elevation: 1,
          actions: <Widget>[
            FavoriteButton(
              iconDisabledColor: Colors.black12,
              isFavorite: false,
              valueChanged: (_isFavorite) {
                print('Is Favorite : $_isFavorite');
              },
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share_rounded),
              iconSize: 35,
            ),
            const SizedBox(
              width: 7,
            )
          ],
        ),
        body: ListView(
          children: [Top(goods: goodsList[0])],
        ));
  }
}
