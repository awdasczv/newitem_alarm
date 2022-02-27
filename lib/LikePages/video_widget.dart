import 'package:flutter/material.dart';
import '../model/Favorite_button.dart';

class VideoWidget extends StatelessWidget{
  const VideoWidget ({Key key}) : super(key:key);
//위젯 구성값을 2개로 나눠 안에 기능 구현

  Widget _thumnail(){
    return Container(
      height: 200,
      color: Colors.grey.withOpacity(0.5),
    );
  }

  Widget _simpleDeatilinfo(){
    return Stack (
      children:[
      Container(
      child: Row(children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("한국에서 제일 매운 컵라면 킹뚜껑 먹방",
                  maxLines:3,),
                  Positioned(
                  child: FavoriteButton(
                    iconSize: 40,
                    iconDisabledColor:Colors.black87,
                    isFavorite: false,
                    valueChanged:(_isFavorite) {
                      print('Is Favorite : $_isFavorite');
                    },
                  ),
                )],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  //이미지 넣는 부분
                  //backgroundImage: Image.network(
                  //  metadata.channel_thumbnails)
                  //.image,
                ),
                  SizedBox(
                    width: 5,
                  ),
                Text("입짧은햇님",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.8),
                )
                )
                ],)
            ],),
        )
      ],)
    ),]
    );
  }



  @override
  Widget build(BuildContext context) {
    return Hero(
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
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      _thumnail(),
                  _simpleDeatilinfo(),
                  ],
                )
                )
            )
        )
    );
  }
}