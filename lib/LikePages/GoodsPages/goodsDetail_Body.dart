// import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/goods.dart';

class Body extends StatelessWidget {
  final Goods goods; //goods.dart에 있는 Goods 객체 넘겨받기
  Body({Key key, @required this.goods}) : super(key: key);
  //StatelessWidget에서 super.initState();가 안되어서 일단 주석처리함.
  // int _currentPage = 0;
  // PageController pageController = PageController(initialPage: 0);
  //
  // @override
  // void initState() {
  //   //Pageview 자동 스크롤
  //   super.initState();
  //   Timer.periodic(Duration(seconds: 5), (Timer timer) {
  //     //import 'dart:async';해서 Timer 사용
  //     if (_currentPage < 2) {
  //       _currentPage++;
  //     } else {
  //       _currentPage = 0;
  //     }
  //     pageController.animateToPage(_currentPage,
  //         duration: Duration(milliseconds: 350), curve: Curves.easeInSine);
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PageView(
          // controller: pageController,
          children: [
            Container(
              height: 200,
              child: Image.network(
                goods.imageUrl1 ?? "",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 200,
              child: Image.network(goods.imageUrl2 ?? "", fit: BoxFit.cover),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Image.network(goods.brandlogo ?? ""),
                    radius: 40,
                  ),
                  Text(
                    goods.title ?? "",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    '${goods.starScore}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  Text("(${goods.review})",
                      style: TextStyle(fontSize: 10, color: Colors.black)),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_outlined,
                      size: 10,
                      color: Colors.black87,
                    ), //후에 리뷰랑 연결하기
                    label: Text(
                      "리뷰 보러가기",
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black26)),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "가격",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("${goods.price}" + "원",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "출시일",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(goods.launchdate ?? "",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "영양성분",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                    color: Colors.black,
                    iconSize: 15,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 500,
                child: Divider(
                  color: Colors.black54,
                  thickness: 1.5,
                ),
              ), //구분선
              const SizedBox(
                height: 10,
              ),
              Text(goods.describe ?? ""),
            ],
          ),
        )
      ],
    );
  }
}
