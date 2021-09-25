import 'package:flutter/material.dart';
class WatchList extends StatefulWidget {

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList > {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title : Container(
              child: Text("WATCH"),
            ),
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context,index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      height: 150,
                      color: Colors.grey
                  ),
                );
              },
              childCount: 10,
            ),)
        ],
      ),

    );
  }
}