import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/category_controller.dart';

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
    '빵집',
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
          height: 28,
          child: GetBuilder(
            init: categoryController(),
            builder: (val) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return categoryMethod(index);
                }),
          )),
    );
  }

  Widget categoryMethod(int index) {
    // double bar_width =
    //     category[index].length.roundToDouble() * 12; //음절 수 * 글자 크기
    final catgory_cntrl = Get.put(categoryController());
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
          TabBarView();
        });
      },
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: currentIndex == index
                  ? Color(0xfffbeeb7)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(category[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentIndex == index
                          ? Color(0xffaa8a0a)
                          : Colors.black38,
                      fontSize: 15)),
              // Container(
              //   margin: EdgeInsets.only(top: 2), //top padding
              //   height: 2,
              //   width: bar_width,
              //   color:
              //       currentIndex == index ? Colors.black : Colors.transparent,
              // )
            ],
          )),
    );
  }
}
