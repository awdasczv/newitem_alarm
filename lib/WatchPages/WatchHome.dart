import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newitem_alarm/main.dart';
import 'package:http/http.dart' as http;

class WatchHome extends StatefulWidget {
  static String routeName = "/WatchHome";

  @override
  _WatchHomeState createState() => _WatchHomeState();
}

const String api_key = "AIzaSyABPzqx5k1q_Le_cIVTsbaiCgeUZwo04XA";

class YoutubeAPI{
  String channel_id;
  String video_id;
  String channel_thumbnails;
  String video_thumbnails;
  String video_title;
  String channel_name;
  String video_discription;
  String video_published_date;

  YoutubeAPI({
    @required this.channel_id,
    @required this.video_id,
    @required this.channel_thumbnails,
    @required this.video_thumbnails,
    @required this.video_title,
    @required this.channel_name,
    @required this.video_discription,
    @required this.video_published_date
  });
  factory YoutubeAPI.fromJson(Map<String, dynamic> channelJson, Map<String, dynamic> videoJson){
    return YoutubeAPI(
        channel_id: channelJson['id'],
        video_id: videoJson['id'],
        channel_thumbnails: channelJson['snippet']['thumbnails']['default']['url'],
        video_thumbnails: videoJson['snippet']['thumbnails']['maxres']['url'],
        video_title: videoJson['snippet']['title'],
        channel_name: channelJson['snippet']['title'],
        video_discription: videoJson['snippet']['description'],
        video_published_date : videoJson['snippet']['publishedAt']
    );
  }
}

//예시 체널정보 api 링크 https://www.googleapis.com/youtube/v3/channels?id=UCsJ6RuBiTVWRX156FVbeaGg&key=AIzaSyABPzqx5k1q_Le_cIVTsbaiCgeUZwo04XA&part=snippet
//예시 동영상 정보 api 링크 https://www.googleapis.com/youtube/v3/videos?id=1BFakMxJUIg&key=AIzaSyABPzqx5k1q_Le_cIVTsbaiCgeUZwo04XA&part=snippet

Future<List<YoutubeAPI>> fetchYoutubeMetaData(List<String> channelIDList, List<String> youtubeLinkList)async{

  List<YoutubeAPI> res = [];
  for(int i = 0 ; i < channelIDList.length ; i++){
    String _request1 = 'https://www.googleapis.com/youtube/v3/channels?id=' + channelIDList[i] + '&key=AIzaSyABPzqx5k1q_Le_cIVTsbaiCgeUZwo04XA&part=snippet';//체널정보
    String _request2 = 'https://www.googleapis.com/youtube/v3/videos?id=' + getYoutubeVideoId(youtubeLinkList[i]) + '&key=AIzaSyABPzqx5k1q_Le_cIVTsbaiCgeUZwo04XA&part=snippet';//유튜브 동영상정보
    final _res1 = await http.get(Uri.parse(_request1));//체널정보
    final _res2 = await http.get(Uri.parse(_request2));//유튜브 동영상정보

    if(_res1.statusCode == 200 && _res2.statusCode == 200){
      var channelJson = jsonDecode(_res1.body)['items'][0];
      var videoJson = jsonDecode(_res2.body)['items'][0];

      res.add(YoutubeAPI.fromJson(channelJson, videoJson));

    }
    else throw Exception("Fail to load ArvInfo");
  }
  return res;

}

class _WatchHomeState extends State<WatchHome> {

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

  Future<List<YoutubeAPI>> futureYoutubeAPI;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureYoutubeAPI = fetchYoutubeMetaData(_testYoutubeChannelId, _testYoutubeLink);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '워치',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),
          ),
        ),
        body: Column(
          children: [Expanded(child: _futureBuilder())],
        ));
  }

  FutureBuilder<List<YoutubeAPI>> _futureBuilder(){
    return FutureBuilder<List<YoutubeAPI>>(
        future: futureYoutubeAPI,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return _wholeWidgetView(snapshot.data);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
    );
  }


  Widget _wholeWidgetView(List<YoutubeAPI> _data) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
            height: 244,
            child: _rowListView(_data),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black26,
            thickness: 5,
          );
        },
        itemCount: 10);
  }

  Widget _rowListView(List<YoutubeAPI> _data) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: _data.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index != _data.length) {
          return _youtubeThumbnail(_data[index]);
        } else
          return IconButton(
              onPressed: () {},
              iconSize: 50,
              icon: Icon(
                Icons.double_arrow,
                color: Colors.black54,
              ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 40,
        );
      },
    );
  }

  Widget _youtubeThumbnail(YoutubeAPI metadata) {
    return SizedBox(
      width: 306,
      height: 240,
      child: Hero(
        //watch좋아요Card 눌렀을 때 나오는 watch상세페이지와 연결되도록 tag하기 (후에 할 일)
        tag: 'watchLikeCard',
        child: Card(
            elevation: 2, //그림자 깊이
            margin: EdgeInsets.all(2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
                onTap: () {}, //후에 클릭하면 상세페이지로 이동하도록 수정해야 함.
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[_thumbnail(metadata.video_thumbnails), _watchInfo(metadata)],
                  ),
                ))),
      ),
    );
  }

  Widget _thumbnail(String url) {
    return Container(
      height: 162,
      width: 288,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: Image.network(url).image,
      )),
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



String getYoutubeThumbnailImageLink(String url) {
  return 'https://img.youtube.com/vi/' +
      getYoutubeVideoId(url) +
      '/maxresdefault.jpg';
}

String getYoutubeVideoId(String url) {
  String _res = '';
  for (int i = 0; i < url.length - 1; i++) {
    if (url[i] == 'v' && url[i + 1] == '=') {
      for (int j = i + 2; url[j] != '&'; j++) {
        _res = _res + url[j];
      }
      break;
    }
  }
  return _res;
}
