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
            //theme: ThemeData(primaryColor: Colors.white), //전체테마 변경
            home: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
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
      child: Column(
        children: <Widget>[
          Card(
            elevation: 2, //그림자 깊이
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {}, //후에 클릭하면 페이지로 이동하도록 수정해야 함.
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                          "https://t1.daumcdn.net/cfile/tistory/9994463B5C2B89F731"),
                    )
                  ],
                ),
              ),
            ), //Card 위젯에 onTap과 같은 위젯 탭하는 액션 추가하기 위해
          ), //margin 바깥쪽
        ],
      ),
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
