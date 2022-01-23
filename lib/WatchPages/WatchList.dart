import 'package:flutter/material.dart';
import 'package:newitem_alarm/WatchPages/WatchDetail.dart';
import 'package:newitem_alarm/model/YoutubeApiModel.dart';
class WatchList extends StatefulWidget {

  @override
  _WatchListState createState() => _WatchListState();

  final List<YoutubeAPI> videoDataList;

  const WatchList({Key key, this.videoDataList}) : super(key: key);
}

class _WatchListState extends State<WatchList > {

  final _testYoutubeChannelId = [
    'UCsJ6RuBiTVWRX156FVbeaGg',//슈카
    'UCM31rBPQdifQKUmBKtwVqBg',//1분만
    'UCaKod3X1Tn4c7Ci0iUKcvzQ', //런닝맨
    'UCF2AFWB3tROplgmkt3nOXIw',//훼사원
    'UC-YRx5jfreS9abTGxfmV4Hg'//칩
  ];

  final _testYoutubeLink = [
    'https://www.youtube.com/watch?v=1BFakMxJUIg&ab_channel=%EC%8A%88%EC%B9%B4%EC%9B%94%EB%93%9C', //슈카
    'https://www.youtube.com/watch?v=s9gnQF9lT8E&ab_channel=1%EB%B6%84%EB%A7%8C', //1분만
    'https://www.youtube.com/watch?v=P3p3_i-bmms&t=94s&ab_channel=%EB%9F%B0%EB%8B%9D%EB%A7%A8-%EC%8A%A4%EB%B8%8C%EC%8A%A4%EA%B3%B5%EC%8B%9D%EC%B1%84%EB%84%90', //런닝맨
    'https://www.youtube.com/watch?v=MEVYc7wi1K8&t=1215s&ab_channel=%ED%9B%BC%EC%82%AC%EC%9B%90', //훼사원
    'https://www.youtube.com/watch?v=0zwMMLaM260&t=16s&ab_channel=%EC%B9%A9chip', //칩
  ];

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
      ),
      body: ListView.builder(
        itemCount: widget.videoDataList.length,
          itemBuilder: (BuildContext context, int index){
            return _youtubeThumbnail(widget.videoDataList[index]);
          }
      ),
    );
  }

  Widget _youtubeThumbnail(YoutubeAPI metadata) {
    return Hero(
      //watch좋아요Card 눌렀을 때 나오는 watch상세페이지와 연결되도록 tag하기 (후에 할 일)
      tag: metadata.video_id,
      child: Card(
          elevation: 2, //그림자 깊이
          margin: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WatchDetail(videoData: metadata,) ));
              }, //후에 클릭하면 상세페이지로 이동하도록 수정해야 함.
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[_thumbnail(metadata.video_thumbnails), _watchInfo(metadata)],
                ),
              ))),
    );
  }

  Widget _thumbnail(String url) {
    return Container(
      child: Image.network(url),
    );
  }

  Widget _watchInfo(YoutubeAPI metadata) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.withOpacity(0.6),
              backgroundImage: Image.network(
                  metadata.channel_thumbnails)
                  .image,
            ),
            SizedBox(
              width: 13,
            ),
            Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            metadata.video_title,
                            style: TextStyle(fontSize: 15),
                            maxLines: 1,
                          ),
                        ), //Title 길때 2줄까지
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          metadata.channel_name,
                          style: _style(),
                        ),
                        SizedBox(
                          width: 3,
                        ),


                        Text(
                          "·",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          metadata.video_published_date.substring(0,10),
                          style: TextStyle(
                              fontSize: 14, color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    )
                  ],
                )
            )
          ],
        ));
  }

  TextStyle _style() {
    return TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5));
  }
}