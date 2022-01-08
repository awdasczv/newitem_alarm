import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/goods_controller.dart';
import '../model/Favorite_button.dart';

class GoodsCard extends StatelessWidget {
  final String title;
  final String brand;
  final String imageUrl1;
  final int price;
  final double starScore;
  final int total_review_count;
  final bool isFavorite;
  final String category;

  GoodsCard(this.title, this.brand, this.imageUrl1, this.price, this.starScore,
      this.total_review_count, this.isFavorite, this.category);
  final goods_cntrl = Get.put(goodsController());
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Card(
                elevation: 1,
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
                          image: NetworkImage(this.imageUrl1))),
                ),
              ),
              Positioned(
                left: 130,
                right: 0,
                bottom: 10,
                child: FavoriteButton(
                  iconSize: 40,
                  iconDisabledColor: Colors.black87,
                  isFavorite: this.isFavorite, //찜목록에 있으니까
                  valueChanged: (_isFavorite) {
                    print('Is Favorite : $_isFavorite');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 1,
          ),
          RichText(
              maxLines: 2,
              text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: <TextSpan>[
                    TextSpan(
                        text: this.brand,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' ' + this.title)
                  ])),
          //RichText는 text마다 각각 다른 스타일을 적용하고 싶을 때
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Icon(
                Icons.star_rounded,
                size: 20,
                color: Colors.amberAccent,
              ),
              Text(
                this.starScore.toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  "(${this.total_review_count.toString()})",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Text(
            '${this.price}원',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ]);
  }
}
