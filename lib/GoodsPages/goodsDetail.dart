import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/goods.dart';

import '../model/Favorite_button.dart';
import 'goodsDetail_Body.dart';

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
        backgroundColor: Colors.grey[200],
        appBar: buildAppBar(context),
        body: ListView(
          children: [Top(goods: widget.goods)],
        ));
  }

  // Top(goods: widget.goods)

  //Extract Method 단축키 Ctrl+Alt+M
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black87,
        ),
        iconSize: 30,
        tooltip: 'Back Icon',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        FavoriteButton(
          iconSize: 50,
          iconDisabledColor: Colors.black87,
          isFavorite: false,
          valueChanged: (_isFavorite) {
            print('Is Favorite : $_isFavorite');
          },
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share_rounded),
          color: Colors.black87,
          iconSize: 30,
        ),
        const SizedBox(
          width: 7,
        )
      ],
    );
  }
}
