import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/YoutubeApiModel.dart';

class WatchDetail extends StatefulWidget {
  final YoutubeAPI videoData;

  const WatchDetail({Key key, this.videoData}) : super(key: key);

  @override
  _WatchDetailState createState() => _WatchDetailState();
}

class _WatchDetailState extends State<WatchDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)
        ),
        title: Text(
          '워치',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (){},//유튜브 링크 연결하여 여는 함수 추가해야되........
              child: Text('유튜브로 열기')
          )
        ],
      ),
      body: Center(
        child: Text(widget.videoData.channel_name),
      ),
    );
  }
}
