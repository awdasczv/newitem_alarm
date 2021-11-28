import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/goods.dart';

class Body extends StatefulWidget {
  final Goods goods; //goods.dart에 있는 Goods 객체 넘겨받기
  const Body({Key key, @required this.goods}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  TabController _tabController; //TabView
  final bar = ['상품설명', '리뷰', '상세정보'];

  @override
  void initState() {
    //Pageview 자동 스크롤
    super.initState();
    this._tabController = TabController(length: bar.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override //main
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.goods.title),
    ); //StatelessWidget이면 그냥 goods.~이어도 parameter를 State에 pass할 수 있지만, //StatefulWidget이면 widget.goods.~로 pass
  }
}

class Top extends StatefulWidget {
  final Goods goods; //goods.dart에 있는 Goods 객체 넘겨받기
  const Top({Key key, @required this.goods}) : super(key: key);

  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  int _currentimage = 0;
  List<String> imageList = [
    goodsList[0].imageUrl1,
    goodsList[0].imageUrl2,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Stack(
          overflow: Overflow.visible, //overflow된 자식 보이게
          fit: StackFit.loose, //Stack에서 Positioned 안된 자식 크기 조정(loose하게)
          // alignment: Alignment.center,
          children: [
            CarouselSlider(
              items: imageList.map((item) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.network(item),
                          ),
                        ))); //ClipRect : Clips the image in rectangle //ClipRRect : Clips the image in circle
              }).toList(),
              options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentimage = index;
                    });
                  }),
            ),
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 30.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.map((url) {
                    int index = imageList.indexOf(url);
                    return Container(
                      width:
                          8.0, //기기 가로사이즈 // MediaQuery.of(context).size.width
                      height: 10.0,
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentimage == index
                              ? Colors.black26
                              : Colors.black),
                    );
                  }).toList(),
                )),
            Positioned.fill(
                bottom: -MediaQuery.of(context).size.height * .28,
                // top: MediaQuery.of(context).size.height * .50,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 230,
                        width: MediaQuery.of(context).size.width * .93,
                      ),
                    )))
          ],
        ),
      ],
    ));
  }
}
