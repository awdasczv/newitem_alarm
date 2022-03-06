import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newitem_alarm/model/goods.dart';


Map<int,String> category = {
  1 : '젤리/초콜릿',
  2 : '빵집',
  3 : '음료',
  4 : '카페/디저트',
  5 : '주류',
  6 : '라면',
  7 : '햄버거',
  8 : '피자',
  9 : '치킨',
  10 : '즉석/냉동',
  11 : '아이스크림',
  12 : '과자'
};

class ReviewData{
  final String uid;
  final double starScore;
  final String goodsID;
  final List<String> reviewImageUrl;
  final DateTime updateTime;
  final String mainText;

  ReviewData({
    this.uid,
    this.starScore = 0,
    this.mainText = "",
    this.reviewImageUrl = const [""],
    this.updateTime,
    this.goodsID
});
  void uploadReview ()async{
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User _user = _firebaseAuth.currentUser;
    
    await _firebaseFirestore.collection('Goods').doc(goodsID).set({});
  }
}

class NewGoods{
  final String id;
  final int category;
  final String brand;
  final List<String> imageURL;
  final String title;
  final int price;
  final double starScore;
  final String describe;
  final String launchdate;
  final int reviewNum;
  final int commentNum;
  final int MukTVNum;

  NewGoods({
    this.id = "",
    this.category,
    this.brand,
    this.imageURL,
    this.title,
    this.price,
    this.starScore = 3.7,
    this.describe = "",
    this.launchdate,
    this.reviewNum = 0,
    this.commentNum = 0,
    this.MukTVNum = 0
  });

  factory NewGoods.fromJson(Map<String,dynamic> json)  {

    List _list = json['imageURL'];

    return NewGoods(
    id : json['id'],
    category : json['category'],
    brand : json['brand'],
    imageURL : _list.cast<String>(),
    title : json['title'],
    price : json['price'],
    starScore : json['starScore'],
    describe : "",
    launchdate : json['launchdate'],
    reviewNum : json['reviewNum'],
    commentNum : json['commentNum'],
    MukTVNum : json['MukTVNum']
    );
  }


  Future<String> getID() async{
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    String _category;
    String _index;
    var _finalIndex;

    if(category < 10){
      _category = "0" + category.toString();
    }else _category = category.toString();

    try{
      await _firebaseFirestore.collection('Goods').doc('metadata').collection('final_index').doc(launchdate + '-' + _category).get().then((value) => _finalIndex = value.get('final_index'));
    }catch(e){
      _finalIndex = null;
    }

    if(_finalIndex == null) {_finalIndex = 1;}
    else _finalIndex++;

    if(_finalIndex < 10) _index = "000" + _finalIndex.toString();
    else if(_finalIndex < 100) _index = "00" + _finalIndex.toString();
    else if(_finalIndex < 1000) _index = "0"  + _finalIndex.toString();
    else _index = _finalIndex.toString();

    return launchdate + '-' + _category + '-' + _index;
  }

  void uploadNewGoods() async{
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    String _category;
    String _index;
    var _finalIndex;

    if(category < 10){
      _category = "0" + category.toString();
    }else _category = category.toString();

    try{
      await _firebaseFirestore.collection('Goods').doc('metadata').collection('final_index').doc(launchdate + '-' + _category).get().then((value) => _finalIndex = value.get('final_index'));
    }catch(e){
      _finalIndex = null;
    }

    if(_finalIndex == null) {_finalIndex = 1;}
    else _finalIndex++;

    if(_finalIndex < 10) _index = "000" + _finalIndex.toString();
    else if(_finalIndex < 100) _index = "00" + _finalIndex.toString();
    else if(_finalIndex < 1000) _index = "0"  + _finalIndex.toString();
    else _index = _finalIndex.toString();

    await _firebaseFirestore.collection('Goods').doc('metadata').collection('final_index').doc(launchdate + '-' + _category).set({'final_index' : _finalIndex});

    await _firebaseFirestore.collection('Goods').doc(launchdate + '-' + _category + '-' + _index).set({
      'title' : title,
      'starScore' : starScore,
      'price' : price,
      'reviewNum' : reviewNum,
      'commentNum' : commentNum,
      'MukTVNum' : MukTVNum,
      'id' : launchdate + '-' + _category + '-' + _index,
      'category' : category,
      'brand' : brand,
      'imageURL' : imageURL,
      'launchdate' : launchdate
    });

    print("success upload new goods!!");
  }
}

void fireStoreTempUpload() async{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  for(int i = 0 ; i < _newGoods.length ; i++){await _newGoods[i].uploadNewGoods();}


  print('완료');
}

List<NewGoods> _newGoods= [
  NewGoods(
    brand: goodsList[0].brand,
    imageURL: goodsList[0].imageUrl,
    title: goodsList[0].title,
    price: goodsList[0].price,
    launchdate: '2112',
    starScore: goodsList[0].starScore,
    reviewNum: goodsList[0].total_review_count,
    category: 6
  ),
  NewGoods(
      brand: goodsList[1].brand,
      imageURL: goodsList[1].imageUrl,
      title: goodsList[1].title,
      price: goodsList[1].price,
      launchdate: '2112',
      starScore: goodsList[1].starScore,
      reviewNum: goodsList[1].total_review_count,
      category: 12
  ),
  NewGoods(
      brand: goodsList[2].brand,
      imageURL: goodsList[2].imageUrl,
      title: goodsList[2].title,
      price: goodsList[2].price,
      launchdate: '2112',
      starScore: goodsList[2].starScore,
      reviewNum: goodsList[2].total_review_count,
      category: 12
  ),
  NewGoods(
      brand: goodsList[3].brand,
      imageURL: goodsList[3].imageUrl,
      title: goodsList[3].title,
      price: goodsList[3].price,
      launchdate: '2112',
      starScore: goodsList[3].starScore,
      reviewNum: goodsList[3].total_review_count,
      category: 12
  )
];

