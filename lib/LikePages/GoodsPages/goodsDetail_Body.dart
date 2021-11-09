import 'dart:async';

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
  PageController _pageController = PageController(initialPage: 0);
  TabController _tabController; //TabView
  final bar = ['상품설명', '리뷰', '상세정보'];

  @override
  void initState() {
    //Pageview 자동 스크롤
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      //import 'dart:async';해서 Timer 사용
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 350), curve: Curves.easeInSine);
      this._tabController = TabController(length: bar.length, vsync: this);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: bar.length,
        child:
            Scaffold()); //StatelessWidget이면 그냥 goods.~이어도 parameter를 State에 pass할 수 있지만, //StatefulWidget이면 widget.goods.~로 pass
  }
}
