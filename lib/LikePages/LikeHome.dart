import 'package:flutter/material.dart';

class LikeHome extends StatefulWidget {
  @override
  _LikeHomeState createState() => _LikeHomeState();
}

class _LikeHomeState extends State<LikeHome> {
  final bars = [
    Text(
      '상품',
      style: TextStyle(fontSize: 20),
    ),
    Text(
      '워치',
      style: TextStyle(fontSize: 20),
    )
  ];
  //탭바 제목
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: bars.length,
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(
            title: Text("찜목록",
                style: TextStyle(fontSize: 25, color: Colors.black)),
            bottom: TabBar(
              onTap: (index) {},
              tabs: bars.map((Text _bar) {
                return Tab(
                  icon: _bar,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              GoodsPage(),
              WatchPage(), //위젯화면
            ],
          ),
        )));
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
    return Container();
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
