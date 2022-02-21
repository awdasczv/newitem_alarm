import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/goods.dart';

import './MukTV.dart';
import 'comment/Comment.dart';
import 'review/Review.dart';

class Bottom extends StatefulWidget {
  final Goods goods;

  const Bottom({Key key, this.goods}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> with SingleTickerProviderStateMixin {
  final mainColor = Color(0xffFFC845);
  TabController _tabController;
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
            child: TabBar(
              labelColor: mainColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          //IndexedStack will show a single child from a list of children based on index
          // while Visibility will maintain to show or hide view.
          IndexedStack(
            children: <Widget>[
              Visibility(
                child: Comment(),
                maintainState: true, //invisible할 때도 child 유지
                visible: currentIndex == 0,
              ),
              Visibility(
                child: Review(
                  goods: widget.goods,
                ),
                maintainState: true,
                visible: currentIndex == 1,
              ),
              Visibility(
                child: MukTV(),
                maintainState: true,
                visible: currentIndex == 2,
              ),
            ],
            index: currentIndex, //index는 The index of the child to show.
          )
        ],
      ),
    );
  }
}
