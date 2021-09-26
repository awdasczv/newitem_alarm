import 'package:flutter/material.dart';

class WatchHome extends StatefulWidget {
  @override
  _WatchHomeState createState() => _WatchHomeState();
}

class _WatchHomeState extends State<WatchHome> {

  final _testYoutubeLink = [
    'https://www.youtube.com/watch?v=1BFakMxJUIg&ab_channel=%EC%8A%88%EC%B9%B4%EC%9B%94%EB%93%9C',//슈카
    'https://www.youtube.com/watch?v=s9gnQF9lT8E&ab_channel=1%EB%B6%84%EB%A7%8C',//1분만
    'https://www.youtube.com/watch?v=P3p3_i-bmms&t=94s&ab_channel=%EB%9F%B0%EB%8B%9D%EB%A7%A8-%EC%8A%A4%EB%B8%8C%EC%8A%A4%EA%B3%B5%EC%8B%9D%EC%B1%84%EB%84%90',//런닝맨
    'https://www.youtube.com/watch?v=MEVYc7wi1K8&t=1215s&ab_channel=%ED%9B%BC%EC%82%AC%EC%9B%90',//훼사원
    'https://www.youtube.com/watch?v=0zwMMLaM260&t=16s&ab_channel=%EC%B9%A9chip',//칩
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('워치',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(getYoutubeVideoId(_testYoutubeLink[0])),
          Text(getYoutubeVideoId(_testYoutubeLink[1])),
          Text(getYoutubeVideoId(_testYoutubeLink[2])),
          Text(getYoutubeVideoId(_testYoutubeLink[3])),
          Text(getYoutubeVideoId(_testYoutubeLink[4])),
          Text(_testYoutubeLink[4]),
        ],
      ),
    );
  }

  Widget _youtubeThumbnail(){
    return Container(
    );
  }


}

String getYoutubeVideoId(String url){
  String _res = '';
  for(int i = 0 ; i < url.length - 1 ; i++){
    if(url[i] == 'v' && url[i+1] == '='){
      for(int j = i+2 ; url[j] != '&' ; j++){
        _res = _res + url[j];
      }
      break;
    }
  }
  print(_res);
  return _res;
}