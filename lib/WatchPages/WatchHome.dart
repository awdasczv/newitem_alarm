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
        children: [
          Expanded(child: _wholeWidgetView())
        ],
      )
    );
  }

  Widget _wholeWidgetView(){
    return ListView.separated(
      scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index){
          return Container(
            padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
            height: 244,
            child: _rowListView(),
          );
        },
        separatorBuilder: (BuildContext context, int index){
          return Divider(
            color: Colors.black26,thickness: 5,
          );
        },
        itemCount: 10
    );
  }

  Widget _rowListView(){
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
        itemCount: _testYoutubeLink.length + 1,
        itemBuilder: (BuildContext context, int index){
          if(index != _testYoutubeLink.length ){
            return _youtubeThumbnail(_testYoutubeLink[index]);
          }
          else return IconButton(
              onPressed: (){},
              iconSize: 50,
              icon: Icon(Icons.double_arrow,color: Colors.black54,)
          );
        },
        separatorBuilder: (BuildContext context, int index){return SizedBox(width: 40,);},
    );
  }

  Widget _youtubeThumbnail(String url){
    return SizedBox(
      width: 306,
      height: 240,
      child:  Hero(
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
                    children: <Widget>[_thumbnail(url), _watchInfo(url)],
                  ),
                )
            )
        ),

      ),

    );
  }

  Widget _thumbnail(String url) {
    return Container(
      height: 162,
      width: 288,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.network(getYoutubeThumbnailImageLink(url)).image,
        )
      ),
    );
  }

  Widget _watchInfo(String url) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.withOpacity(0.6),
              backgroundImage: Image.network(
                  "https://t1.daumcdn.net/cfile/tistory/9994463B5C2B89F731")
                  .image,
            ),
            SizedBox(
              width: 13,
            ),
            Expanded(
               child:  Column(
                 children: [
                   Row(
                     children: [
                       Expanded(
                         child: Text(
                           "Watch Title",
                           style: TextStyle(fontSize: 16),
                           maxLines: 2,
                         ),
                       ), //Title 길때 2줄까지
                     ],
                   ),
                   Row(
                     children: [
                       Text(
                         "Name",
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
                         "조회수",
                         style: _style()
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
                         "20XX-0X-XX",
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
  TextStyle _style(){
    return TextStyle(
        fontSize: 12,
        color: Colors.black.withOpacity(0.5)
    );
  }
}

String getYoutubeThumbnailImageLink(String url){
  return 'https://img.youtube.com/vi/' + getYoutubeVideoId(url) + '/maxresdefault.jpg';
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