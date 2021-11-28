import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newitem_alarm/model/YoutubeApiModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchDetail extends StatefulWidget {
  final YoutubeAPI videoData;

  const WatchDetail({Key key, this.videoData}) : super(key: key);

  @override
  _WatchDetailState createState() => _WatchDetailState();
}

class _WatchDetailState extends State<WatchDetail> {

  YoutubePlayerController _youtubePlayerController;
  YoutubeMetaData _playerMetaData;

  PlayerState _playerState;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  bool _likeIsPressed = false;
  bool _dislikeIsPressed = false;
  bool _wishIsPressed = false;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _youtubePlayerController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                _youtubePlayerController.metadata.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {
                print('Settings Tapped!');
              },
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
          onEnded: (data) {
            _youtubePlayerController.load(widget.videoData.video_id);
          },
        ),

        builder: (context, player){
          return Scaffold(
            appBar: _appBar(),
            body: Column(
              children: [
                player,
                _watchInfo(widget.videoData),
                _divider(),
                _row(),
                _divider()
              ],
            ),
          );
        }
    );
  }

  Row _row(){
    return Row(
      children: [
        SizedBox(width: 10,),
        IconButton(
            onPressed: (){setState(() {_likeIsPressed = !_likeIsPressed; print(_likeIsPressed);});},
            icon: _icon(0,_likeIsPressed)
        ),
        SizedBox(width: 10,),
        IconButton(
            onPressed: (){setState(() {_dislikeIsPressed = !_dislikeIsPressed;});},
            icon: _icon(1,_dislikeIsPressed)
        ),
        SizedBox(width: 10,),
        IconButton(
            onPressed: (){setState(() {_wishIsPressed = !_wishIsPressed;});},
            icon: _icon(2,_wishIsPressed)
        ),
        Spacer(),
        Text('상세설명'),
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.expand_more, size: 30,)
        )
      ],
    );
  }

  Icon _icon(int index, bool _isPressed){
    if(index == 0){
      if(!_isPressed){
        return Icon(Icons.thumb_up_alt_outlined, size: 30,);
      }
      else {
        return Icon(Icons.thumb_up_alt, size: 30,);
      }
    }
    else if(index == 1){
      if(!_isPressed){
        return Icon(Icons.thumb_down_alt_outlined, size: 30,);
      }
      else {
        return Icon(Icons.thumb_down_alt, size: 30,);
      }
    }
    else{
      if(!_isPressed){
        return Icon(Icons.favorite_border, size: 30,);
      }
      else {
        return Icon(Icons.favorite, size: 30,);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoData.video_id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _playerMetaData =  const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  AppBar _appBar(){
    return  AppBar(
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
            onPressed: (){
              launch('https://www.youtube.com/watch?v=' + widget.videoData.video_id + '&ab_channel=' + widget.videoData.channel_name, forceWebView: false, forceSafariVC: false);
            },//유튜브 링크 연결하여 여는 함수 추가해야되........
            child: Text('유튜브로 열기')
        )
      ],
    );
  }

  void listener() {
    if (_isPlayerReady && mounted && !_youtubePlayerController.value.isFullScreen) {
      setState(() {
        _playerState = _youtubePlayerController.value.playerState;
        _playerMetaData = _youtubePlayerController.metadata;
      });
    }
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
                            overflow: TextOverflow.ellipsis,
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

  Divider _divider(){
    return Divider(
      color: Colors.black26,
      thickness: 2,
    );
  }
}