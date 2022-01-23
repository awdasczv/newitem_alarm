import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//예시 체널정보 api 링크 https://www.googleapis.com/youtube/v3/channels?id=UCsJ6RuBiTVWRX156FVbeaGg&key=AIzaSyABPzqx5k1q_Le_cIVTsbaiCgeUZwo04XA&part=snippet
//예시 동영상 정보 api 링크 https://www.googleapis.com/youtube/v3/videos?id=1BFakMxJUIg&key=AIzaSyABPzqx5k1q_Le_cIVTsbaiCgeUZwo04XA&part=snippet

//유튜브 API를 통해 받는 데이터들
class YoutubeAPI{
  String channel_id;//체널 아이디 정보(체널 이름 아님 주의!!)
  String video_id;//영상 아이디 정보(마찬가지로 영상 제목 아님!!)
  String channel_thumbnails;//체널 썸네일 주소 링크
  String video_thumbnails;//비디오 썸네일 주소 링크
  String video_title;//영상 제목
  String channel_name;//체널 이름
  String video_discription;//영상 아래 작성된 설명들(유튜브 영상 더보기 누르면 나오는 것들)
  String video_published_date;//영상이 올라온 날짜 및 시간

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
    //두개의 json request가 필요
    //channelJson은 체널정보(체널 썸네일 같은거)를, videoJson은 특정 영상정보(영상 썸네일이나 설명 같은거)를 받아옴
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

Future<List<YoutubeAPI>> fetchYoutubeMetaData(List<String> channelIDList, List<String> youtubeLinkList)async{
//YoutubeAPI 정보를 fetch해오는 함수
//체널 아이디와 유튜브 링크가 필요

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