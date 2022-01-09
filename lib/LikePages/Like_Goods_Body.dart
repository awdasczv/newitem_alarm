import 'package:flutter/material.dart';
import 'package:newitem_alarm/GoodsPages/goodsDetail.dart';
import 'package:newitem_alarm/model/goods.dart';

import '../LikePages/Category.dart';
import '../LikePages/Goods_Card.dart';
import '../model/goods.dart';

class Like_Goods_Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Category(),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: GridView.builder(
              shrinkWrap: true, //필요한 공간만 차지
              itemCount: goodsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //2행
                  childAspectRatio: 0.65,
                  //mainAxis에 대한 교차축 비율
                  mainAxisSpacing: 10,
                  //mainAxis를 따라 각 child 사이 크기 //위로 얼마나 띄어져 있는지
                  crossAxisSpacing: 10 //같은 행에 있는 child 간 사이 크기
                  ),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailMain(
                                  goods: goodsList[index],
                                )));
                  },
                  child: GoodsCard(
                    goods: goodsList[index],
                  ))),
        ))
      ],
    );
  }
}
