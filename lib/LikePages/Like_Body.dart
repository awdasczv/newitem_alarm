import 'package:flutter/material.dart';

class LikeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('찜목록',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Category() //textTheme
      ],
    );
  }
}

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
    return Container(
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: category.length,
          itemBuilder: (context, index) {
            return categoryMethod(index);
          }),
    );
  }

  Widget categoryMethod(int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          children: [
            Text(category[index],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                    fontSize: 15)),
            Container(height: 2,)
          ],
        ));
  }
}
