import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newitem_alarm/LikePages/video_widget.dart';

import '../LikePages/Like_Goods_Body.dart';
import '../LikePages/likegoods_filter.dart';

class LikeHome extends StatefulWidget {
  static String routeName = "/LikeHome";

  @override
  _LikeHomeState createState() => _LikeHomeState();
}

class _LikeHomeState extends State<LikeHome>
    with SingleTickerProviderStateMixin {
  //SingleTickProviderStateMixin Tab bar controller 애니메이션 처리를 위해(즉, vsync 사용을 위해)
  TabController _tabController; //TabView

  final bar = ['상품', '먹TV'];

  //탭바 제목

  @override
  void initState() {
    this._tabController = TabController(length: bar.length, vsync: this);
    super.initState();
  } //initState() 위젯 생성될 때 호출됨.

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  } //dispose() 위젯 종료될 때(pop) 호출됨.(Controller 객체 제거될 때 변수에 할당된 메모리 제거하기 위해)

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: bar.length,
        child: MaterialApp(
            debugShowCheckedModeBanner:
                false, //우측 상단 debug 리본 보이지 않게(디버그 모드 해제)
            //theme: ThemeData(primaryColor: Colors.white), //전체테마 변경
            home: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  //shadowColor: Colors.black,
                  // centerTitle: true, //title 중앙
                  shape: Border(
                      bottom: BorderSide(color: Colors.black26, width: 1)),
                  backgroundColor: Colors.white,
                  title: const Text("찜",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black)),
                  centerTitle: true,
                  bottom: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    indicatorColor: Colors.black,
                    //선 색깔
                    controller: _tabController,
                    //indicatorSize: TabBarIndicatorSize.label,
                    //tab_indicator_styler에서 가져옴.
                    tabs: bar.map((_bar) {
                      return Tab(
                        text: _bar,
                      ); //_bar는 bars안에 있는 '상품', '워치'
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  //Pageview를 TabBarView로 수정
                  controller: _tabController,
                  //allowImplicitScrolling: true,
                  children: <Widget>[
                    Like_Goods_Body(), //상품 화면
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
        child: CustomScrollView(
      //SliverAppBar보다는 고정된 Appbar가 적절할 것 같아서 CustomScrollView를 다른 View로 수정할 예정
      //pinned:true 속성이 있기 때문에 SliverAppBar 그대로 사용하기로 함.
      //pinned:true(고정하지 않고), 그냥 floating 속성으로 올렸나가 내리면 나오는 식으로 사용하기로 함.
      slivers: [
        SliverAppBar(
          toolbarHeight: 48,
          floating: true,
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          actions: [
            SizedBox(
              child: GoodsFilter(),
              width: 110,
            )
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Goods(index),
              );
            },
            childCount: 10,
          ),
        ),
      ],
    ));
  }
}

Widget Goods(int index) {
  var starScore = index * 0.5;
  var cost = (index + 1) * 1000;
  var favorite = index;
  return SafeArea(
    //충분한 Padding 처리
    top: false,
    bottom: false,
    child: Column(
      children: <Widget>[
        Card(
          elevation: 2, //그림자 깊이
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {},
            // InkWell은 GestureDetector랑 달리 누르면 잉크 퍼지듯이, 후에 클릭하면 페이지로 이동하도록 수정해야 함.
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, //Row일 때, 가로축 기준 위쪽 정렬 //strech
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
                        Text('상품명$index',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        Padding(padding: EdgeInsets.only(bottom: 5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              //수정필요
                              rating: starScore,
                              physics: BouncingScrollPhysics(),
                              //BouncingScrollPhysics() 끝에서 되돌아오는 scroll physics
                              itemBuilder: (context, _) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              },
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemCount: 5,
                              itemSize: 25,
                              direction: Axis.horizontal,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                            ),
                            Text(
                              '$starScore점',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 5)),
                        Text(
                          '$cost원',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                ], //Card 위젯에 onTap과 같은 위젯 탭하는 액션 추가하기 위해
              ), //margin 바깥쪽
            ),
          ),
        ),
      ],
    ),
  );
}

//여기서부터 작업

class WatchPage extends StatefulWidget {
  //워치 화면

  @override
  _WatchPageState createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
          slivers: [
            //sliver list로 여러가지 구현
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return GestureDetector(
                        onTap: () {
                          },
                        child: VideoWidget(),
                        //비디오 형식을 구현하는 부분
                      );


                      },

                childCount: 10,
              ),
            ),
          ],
        ),
    );
  }
}