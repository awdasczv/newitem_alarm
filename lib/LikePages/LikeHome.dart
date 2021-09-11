import 'package:flutter/material.dart';

class LikeHome extends StatefulWidget {
  @override
  _LikeHomeState createState() => _LikeHomeState();
}

class _LikeHomeState extends State<LikeHome> {
  final bar = ["상품", "워치"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: bar.length,
        child: MaterialApp(
            home: Scaffold(
          appBar: AppBar(
            title: Text("찜목록"),
            bottom: TabBar(
              onTap: (index) {},
              tabs: bar.map((String choice) {
                return Tab(
                  text: choice,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.orange,
              ),
            ],
          ),
        )));
  }
}
