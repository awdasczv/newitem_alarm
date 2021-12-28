import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/goods.dart';

import '../LikePages/Goods_Card.dart';
import '../LikePages/Like_Category.dart';
import '../model/goods.dart';

class LikeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Category(),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: GridView.builder(
              itemCount: goodsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 0.8),
              itemBuilder: (context, index) => GoodsCard(
                    goods: goodsList[index],
                  )),
        ))
      ],
    );
  }
}
