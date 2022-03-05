import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  // Animation _favorite;
  // Animation get goodsFavorites => this._favorite;
  // final  ctrl = Get.find();

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> category = [
    '전체',
    '스낵',
    '빵',
    '음료',
    '카페/디저트',
    '주류',
    '라면',
    '햄버거',
    '피자',
    '치킨',
    '즉석/냉동',
    '아이스크림',
    '과자'
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: category.length,
        child: TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          tabs: category
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ));
  }
}
