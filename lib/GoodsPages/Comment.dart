import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newitem_alarm/GoodsPages/WritingReview.dart';
import 'package:newitem_alarm/model/goods.dart';

class Comment extends StatefulWidget {
  final Goods goods;

  const Comment({Key key, this.goods}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  final mainColor = 0xfff1c40f;

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<ReviewData> _sampleReviewList = [
    ReviewData(
        profileImageUrl: 'https://picsum.photos/600/300?random=1',
        nickname: '닉네임1',
        starScore: 4.3,
        reviewImageUrl: 'https://picsum.photos/600/300?random=100',
        updateTime: '20201214',
        mainText : '스스로 길 위의 인생이라 자처하는 정임수 시인의 전화였다. 미국 서부는 심각한 가뭄이 지속되고 있다. 물 가뭄은 눈雪 가뭄도 되는 법. 스키 시즌이 한창일 12월임에도 눈이 없다. 정 시인과 길 떠남은 언제나 산행이었다. 겨울산은 눈 속 야영이 제격인데, 눈 가뭄에 그림이 그려지지 않는다. 인생은 별 볼일 없는 거라 주장하면서도, 신나게 사는 그가 별 구경 제안을?'

    ),
    ReviewData(
        profileImageUrl: 'https://picsum.photos/200/300?random=2',
        nickname: '닉네임2',
        starScore: 4.3,
        reviewImageUrl: 'https://picsum.photos/200/300?random=120',
        updateTime: '20211224',
      mainText: '조슈아트리국립공원에 갑시다. 내일이 그믐이니 꽃처럼 무장무장 피어날 별 잔치 속으로.'
    ),
    ReviewData(
        profileImageUrl: 'https://picsum.photos/200/300?random=3',
        nickname: '정말 기이이이인 닉네임',
        starScore: 4.3,
        reviewImageUrl: 'https://picsum.photos/200/300?random=130',
        updateTime: '20210224',
        mainText: '오오, 멋진 아이디어다. 그믐이라니 더 좋다. 영롱한 별 바다와 마주했던 감동이 떠오른다. 예전 그 별꽃 잔치를 만난 적이 있다. LA 재미한인 산악회와 함께 방문했을 때였다. 사막은 낮과 밤 표정이 달랐다. 낮엔 지글거리는 태양이 폭력이었으나 밤이 되자 온도가 곤두박질쳤다. 춥고 싸늘했던 사막 캠프장. 그러나 하늘에서는 시나브로 마술이 벌어지고 있었다. 숨이 막혔다. 평생 봐온 별들이, 진면목眞面目이 아니라는 걸 그때 깨달았다.  '
    ),
    ReviewData(
        profileImageUrl: 'https://picsum.photos/200/300?random=4',
        nickname: '닉네임4',
        starScore: 4.3,
        reviewImageUrl: 'https://picsum.photos/200/300?random=140',
        updateTime: '20121224',
        mainText: '역시 전문가다. 모두 경험에서 얻은 지혜일 터. 아웃도어에 최적화된 정 시인은 최선에 차선까지도 생각하고 있었다. 장비를 챙긴 우리는 길을 나섰다. 조슈아트리국립공원은 LA 동남부에 위치하고 있다. 2~3시간 정도면 도착할 수 있는 가까운 거리. 공원에 도착하자마자 우리는 캠프장을 찾아 차를 몰았다.\n\n'
        '공원 내 캠핑장은 모두 9군데. 그중 6곳이 선착순First-come First-serve. 인기 많은 점보 록스Jumbo Rocks 캠핑장에 도착했다. 124개의 텐트 사이트를 한 바퀴 돌았으나 이미 만석. 다음으로 점찍은 곳은 히든밸리Hidden Valley 캠프장. 그곳에 딱 한 자리가 비어 있었다. 운이 좋았다. 우리보다 한 발 늦은 사람이 차를 세우며 푸념했다. 3시간 가까이 캠프를 돌며 빈자리를 찾았지만 없어 공원 밖으로 나가야 한다고.'
    ),
    ReviewData(
        profileImageUrl: 'https://picsum.photos/200/300?random=5',
        nickname: '닉네임5',
        starScore: 4.3,
        reviewImageUrl: 'https://picsum.photos/200/300?random=150',
        updateTime: '20220112',
        mainText: '당연히 우리가 확보한 야영장도 바위에 포위된 아늑한 곳이었다. 우리는 서둘러 텐트를 치고 영역표시를 했다. 그리고 가장 높은 뷰포인트를 찾아 석양을 보기 위해 나섰다.'
    ),
    ReviewData(
        profileImageUrl: 'https://picsum.photos/200/300?random=6',
        nickname: '닉네임6',
        starScore: 4.3,
        reviewImageUrl: 'https://picsum.photos/200/300?random=160',
        updateTime: '20220113',
        mainText: '나중에 확인하니 열 배까지는 아니다. 조슈아트리국립공원 크기는 3,208㎢. 한국에서 가장 넓은 면적을 지닌 지리산국립공원은 484㎢이니 그 크기가 상상이 간다. 지리산이 산악인들 사랑을 받는다면 조슈아트리국립공원은 클라이머의 애인이다. 해가 지고 있는데도 바위에 붙어 있는 클라이머들이 많이 보인다. 질펀하게 펼쳐진 바위 군락들은 암벽의 메카답게 아직도 개척이 무궁무진한 바위세상.\n\n'

        '개척된 등반루트만 8,000개가 넘는다. 정부가 나서서 루트를 내줄 리 없으니 모두 충성심 높은 클라이머들 작품일 터. 바윗길 수만 보더라도 클라이머들이 이 공원을 얼마나 사랑하는지 알 수 있다. 쉬운 코스부터 어려운 크랙과 오버행까지 바위꾼들이 상상할 수 있는 모든 루트가 이곳에 다 있다. '
    ),
  ];

  ReviewData _firebaseReviewData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        /*Row(
          children: [
            OutlinedButton(
              child: Text('버튼 1'),
              onPressed: () async{
                await _firebaseFirestore.collection('Review').doc("2").get().then(
                        (DocumentSnapshot ds){
                      _firebaseReviewData = ReviewData(
                          profileImageUrl: ds.get('profileImageUrl'),
                          nickname: ds.get('nickname'),
                          starScore: ds.get('starScore'),
                          reviewImageUrl: ds.get('reviewImageUrl'),
                          updateTime: ds.get('updateTime')
                      );
                    }
                );

                print(_firebaseReviewData.profileImageUrl);

              },
            ),
            OutlinedButton(
              child: Text('버튼 2'),
              onPressed: () async{
                _firebaseFirestore.collection('Review').doc('에부ㅐ부ㅐ부ㅐ붸붸').set({
                  'profileImageUrl': _sampleReviewList[4].profileImageUrl,
                  'nickname': _sampleReviewList[4].nickname,
                  'starScore': _sampleReviewList[4].starScore,
                  'reviewImageUrl': _sampleReviewList[4].reviewImageUrl,
                  'updateTime': _sampleReviewList[4].updateTime
                });
              },
            ),
            OutlinedButton(
              child: Text('버튼 3'),
              onPressed: () async{
                await _firebaseFirestore.collection('Review').doc("2").get().then(
                        (DocumentSnapshot ds){
                      _firebaseReviewData = ReviewData(
                          profileImageUrl: ds.get('profileImageUrl'),
                          nickname: ds.get('nickname'),
                          starScore: ds.get('starScore'),
                          reviewImageUrl: ds.get('reviewImageUrl'),
                          updateTime: ds.get('updateTime')
                      );
                    }
                );
                print(_firebaseReviewData.profileImageUrl);
                a=2;
              },
            ),
          ],
        ),*/
        OutlinedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WritingReview(goods: widget.goods,)));
            },
            child: Text('리뷰 작성하러가기')
        ),
        ListView.builder(
          itemCount: _sampleReviewList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index){
            return _card(index);
          }
        ),
      ],
    );
  }


  Widget _card(int index){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2, //그림자 깊이
        margin: EdgeInsets.all(2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.withOpacity(0.6),
                    backgroundImage: Image.network(_sampleReviewList[index].profileImageUrl).image,
                  ),
                ),
                SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_sampleReviewList[index].nickname,style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        RatingBarIndicator(
                            rating: _sampleReviewList[index].starScore,
                            itemCount: 5,
                            direction: Axis.horizontal,
                            itemSize: 15,
                            itemBuilder: (context, index){
                              return Icon(
                                Icons.star,
                                color: Color(mainColor),
                              );
                            }
                        ),
                        SizedBox(width: 3,),
                        Text('어제',style: TextStyle(fontSize: 13,color: Colors.grey.shade600),)
                      ],
                    )
                  ],
                ),
                Spacer(),
                PopupMenuButton(
                    icon: Icon(Icons.more_vert,color: Colors.grey,),
                    itemBuilder: (context){
                      return [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text('신고하기')
                        )
                      ];
                    },
                  onSelected: (value){
                      if(value == 1){
                        print('신고하기');
                      }
                  },

                ),
              ],
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(),
                  borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: Image.network(_sampleReviewList[index].reviewImageUrl,fit: BoxFit.cover,),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                _sampleReviewList[index].mainText
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewData{
  String profileImageUrl;
  String nickname;
  double starScore;
  String reviewImageUrl;
  String updateTime;
  String mainText;

  ReviewData({
    this.profileImageUrl,
    this.nickname,
    this.starScore,
    this.reviewImageUrl,
    this.updateTime,
    this.mainText
});
}
