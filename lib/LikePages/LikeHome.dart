import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeHome extends StatefulWidget {
  @override
  _LikeHomeState createState() => _LikeHomeState();
}

class _LikeHomeState extends State<LikeHome>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController _pageController; //PageView
  TabController _tabController; //TabView

  final bars = ['상품', '워치'];
  //탭바 제목

  @override
  void initState() {
    _pageController = PageController(initialPage: 0); //첫 번 째 페이지부터 Pageview
    this._tabController = TabController(length: bars.length, vsync: this);
    super.initState();
  } //initState() 위젯 생성될 때 호출됨.

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  } //dispose() 위젯 종료될 때(pop) 호출됨.(Controller 객체 제거될 때 변수에 할당된 메모리 제거하기 위해)

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: bars.length,
        child: MaterialApp(
            theme: ThemeData(primarySwatch: Colors.yellow),
            home: Scaffold(
                appBar: AppBar(
                  title: const Text("찜목록",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: Colors.black)),
                  bottom: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    indicatorColor: Colors.black,
                    controller: _tabController,
                    onTap: (index) {
                      _page = index;
                      _pageController.animateToPage(_page,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.ease);
                    },
                    tabs: bars.map((_bar) {
                      return Tab(
                        text: _bar,
                      ); //_bar는 bars안에 있는 '상품', '워치'
                    }).toList(),
                  ),
                ),
                body: PageView(
                  controller: _pageController,
                  allowImplicitScrolling: true,
                  children: <Widget>[
                    GoodsPage(), //상품 화면
                    WatchPage(), //워치 화면
                  ],
                ))));
  }
}

class GoodsPage extends StatefulWidget {
  //상품 화면
  @override
  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(),
    );
  }
}

class WatchPage extends StatefulWidget {
  //워치 화면

  @override
  _WatchPageState createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
