import 'package:flutter/material.dart';

import '../../model/goods.dart';
import '../LikePages/Like_Category.dart';

class LikeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('찜목록',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Category(),
        Item() //textTheme
      ],
    );
  }
}

class Item extends StatefulWidget {
  final Goods goods;

  const Item({Key key, @required this.goods}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 160,
      decoration: BoxDecoration(color: Colors.green),
    );
  }
}
