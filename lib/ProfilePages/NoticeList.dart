import 'package:flutter/material.dart';

class NoticeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // CustomScrollView는 children이 아닌 slivers를 사용하며, slivers에는 스크롤이 가능한 위젯이나 리스트가 등록가능함
        slivers: <Widget>[
          // 앱바 추가
          SliverAppBar(
            title : Container(
              child: Text("공지사항"),
            ),
            // floating 설정. SliverAppBar는 스크롤 다운되면 화면 위로 사라짐.
            // true: 스크롤 업 하면 앱바가 바로 나타남. false: 리스트 최 상단에서 스크롤 업 할 때에만 앱바가 나타남
            floating: true,
            snap: true,
            // 최대 높이
            expandedHeight: 70,
          ),
          // 리스트 추가
        ],
      ),
    );
  }
}