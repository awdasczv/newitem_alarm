import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final bar = ['댓글', '리뷰', '먹TV'];

  @override
  void initState() {
    this._tabController = TabController(length: bar.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: bar.length, child: Scaffold(
      appBar: ,
    ));
  }
}
