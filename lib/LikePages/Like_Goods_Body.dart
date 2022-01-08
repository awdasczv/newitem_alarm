import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newitem_alarm/GoodsPages/goodsDetail.dart';
import 'package:newitem_alarm/model/goods.dart';

import '../LikePages/Goods_Card.dart';
import '../LikePages/Like_Category.dart';
import '../controller/goods_controller.dart';
import '../model/goods.dart';

class Like_Goods_Body extends StatelessWidget {
  final goods_cntrl = Get.put(goodsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Category(),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: buildGridView(),
        ))
      ],
    );
  }

  Widget buildGridView() {
    return GridView.builder(
        shrinkWrap: true, //필요한 공간만 차지
        itemCount: goodsList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //2행
            childAspectRatio: 0.65, //mainAxis에 대한 교차축 비율
            mainAxisSpacing: 10, //mainAxis를 따라 각 child 사이 크기 //위로 얼마나 띄어져 있는지
            crossAxisSpacing: 10 //같은 행에 있는 child 간 사이 크기
            ),
        itemBuilder: (context, index) => GetBuilder(
            init: goodsController(),
            builder: (val) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailMain(
                                goods: goodsList[index],
                              )));
                },
                child: GoodsCard(
                  goods_cntrl.goods[index].title,
                  goods_cntrl.goods[index].brand,
                  goods_cntrl.goods[index].imageUrl1,
                  goods_cntrl.goods[index].price,
                  goods_cntrl.goods[index].starScore,
                  goods_cntrl.goods[index].total_review_count,
                  goods_cntrl.goods[index].isFavorite,
                  goods_cntrl.goods[index].category,
                ))));
  }
}
