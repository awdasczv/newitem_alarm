import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../model/goods.dart';

class GoodsCard extends StatelessWidget {
  final Goods goods;
  const GoodsCard({Key key, @required this.goods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ), //elevation주고 싶어서 Card사용했지만..
            child: Container(
              height: 190,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(goods.imageUrl1))),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Row(
            children: [
              Text(
                goodsList[0].brand,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 3),
              AutoSizeText(
                goods.title,
                style: TextStyle(fontSize: 14),
                maxLines: 2,
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            '${goods.price}원',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ]);
  }
}
