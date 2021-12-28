import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> category = [
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
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: 30,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (context, index) {
              return categoryMethod(index);
            }),
      ),
    );
  }

  Widget categoryMethod(int index) {
    double bar_width =
        category[index].length.roundToDouble() * 12; //음절 수 * 글자 크기
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(category[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          currentIndex == index ? Colors.black : Colors.black38,
                      fontSize: 15)),
              Container(
                margin: EdgeInsets.only(top: 2), //top padding
                height: 2,
                width: bar_width,
                color:
                    currentIndex == index ? Colors.black : Colors.transparent,
              )
            ],
          )),
    );
  }
}
