import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    return SafeArea(
      //충분한 Padding 처리
      top: false,
      bottom: false,
      child: Column(
        children: <Widget>[
          Hero(
            //상품좋아요Card 눌렀을 때 나오는 상품상세페이지와 연결되도록 tag하기 (후에 할 일)
            tag: 'goodsLikeCard',
            child: Card(
              elevation: 2, //그림자 깊이
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {}, //후에 클릭하면 페이지로 이동하도록 수정해야 함.
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, //Row일 때, 가로축 기준 위쪽 정렬 //strech
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                            "https://t1.daumcdn.net/cfile/tistory/9994463B5C2B89F731"),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, //Column일 때 세로축 기준 왼쪽 정렬
                          children: [
                            Text('상품명',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            Padding(padding: EdgeInsets.only(bottom: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RatingBarIndicator(
                                  rating: 3,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, _) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    );
                                  },
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  itemCount: 5,
                                  itemSize: 25,
                                  direction: Axis.horizontal,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  '3점',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text(
                              '25,000원',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ], //Card 위젯에 onTap과 같은 위젯 탭하는 액션 추가하기 위해
                  ), //margin 바깥쪽
                ),
              ),
            ),
          )
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
    return Column(
      children: [
        _thumbnail(),
        _watchInfo(),
      ],
    );
  }
}

Widget _thumbnail() {
  return Container(
    height: 250,
    color: Colors.grey.withOpacity(0.5),
  );
}

Widget _watchInfo() {
  return Container(
      child: Row(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey.withOpacity(0.5),
        backgroundImage: Image.network(
                "https://flutter-ko.dev/docs/development/ui/widgets/assets")
            .image,
      ),
      Expanded(
          child: Column(
        children: [
          Row(
            children: [
              Text("Watch Title"),
            ],
          ),
          Row(
            children: [],
          )
        ],
      ))
    ],
  ));
}
