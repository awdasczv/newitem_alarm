import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/GoodsPages/goodsDetail_New.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';
import 'package:newitem_alarm/model/goods.dart';

import '../LikePages/Category.dart';
import '../LikePages/Goods_Card.dart';
import '../model/goods.dart';

class Like_Goods_Body extends StatelessWidget {

  Widget _futureGridView(){
    CollectionReference goodsRef = FirebaseFirestore.instance.collection('Goods');
    return FutureBuilder<QuerySnapshot>(
        future: goodsRef.orderBy('launchdate',descending: false).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xfff1c40f))),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final List<QueryDocumentSnapshot<Object>> _newGoodsList = snapshot.data.docs;
          return GridView.builder(
            shrinkWrap: true,
              itemCount: _newGoodsList.length - 1,
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
                            builder: (context) => GoodsDetailHome(
                              goods: NewGoods.fromJson(_newGoodsList[index].data())
                    )));
                  },
                  child: GoodsCard(
                    goods: NewGoods.fromJson(_newGoodsList[index].data(),
                  ))
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Category(),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: _futureGridView()
            ))
      ],
    );
  }

/*
  Widget _previousGridView(){
    return GridView.builder(
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
                      builder: (context) => GoodsDetailHome(
                        goods: goodsList[index],
                      )));
            },
            child: GoodsCard(
              goods: goodsList[index],
            ))),
  }*/
}
