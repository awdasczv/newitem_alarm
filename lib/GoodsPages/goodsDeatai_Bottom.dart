import 'package:flutter/material.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController _textEditingController = TextEditingController();
  int currentIndex = 0;
  final bar = ['댓글', '리뷰', '먹TV'];

  @override
  void initState() {
    this._tabController = TabController(
        length: bar.length, initialIndex: currentIndex, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bar.length,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TabBar(
                isScrollable: true,
                labelColor: Color(0xfff1c40f),
                unselectedLabelColor: Colors.grey,
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicatorColor: Colors.transparent,
                controller: _tabController,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: bar.map((_bar) {
                  return Tab(
                    text: _bar,
                  );
                }).toList(),
                onTap: (int index) {
                  setState(() {
                    currentIndex = index;
                    _tabController.animateTo(index);
                  });
                },
              ),
            ),
          ),
          IndexedStack(
            children: <Widget>[
              Visibility(
                child: Container(
                  height: 200,
                  color: Colors.yellow,
                  child: Center(
                    child: Text('Content left'),
                  ),
                ),
                maintainState: true,
                visible: currentIndex == 0,
              ),
              Visibility(
                child: Container(
                  height: 1000,
                  color: Colors.red,
                  child: Center(
                    child: Text('Content center'),
                  ),
                ),
                maintainState: true,
                visible: currentIndex == 1,
              ),
              Visibility(
                child: Container(
                  height: 1000,
                  color: Colors.red,
                  child: Center(
                    child: Text('Content right'),
                  ),
                ),
                maintainState: true,
                visible: currentIndex == 2,
              ),
            ],
            index: currentIndex,
          )
        ],
      ),
    );
  }
}

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Text('dsd');
  }
}

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Text('sds');
  }
}

class MukTV extends StatefulWidget {
  @override
  _MukTVState createState() => _MukTVState();
}

class _MukTVState extends State<MukTV> {
  @override
  Widget build(BuildContext context) {
    return Text('sdsd');
  }
}
