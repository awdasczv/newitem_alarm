import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';

class ReviewPage extends StatefulWidget {
  final NewGoods goods;

  const ReviewPage({Key key, this.goods}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final mainColor = 0xfff1c40f;

  final CarouselController _carouselController = CarouselController();

  CollectionReference _reviewRef;

  @override
  void initState() {
    // TODO: implement initState
    _reviewRef = FirebaseFirestore.instance.collection('Goods').doc(widget.goods.id).collection('Review');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _futureListView();
  }

  Widget _futureListView(){
    return FutureBuilder<QuerySnapshot>(
        future: _reviewRef.orderBy('updateTime',descending: true).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xfff1c40f))),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final List<QueryDocumentSnapshot<Object>> _reviewList = snapshot.data.docs;

          return ListView.builder(
            itemCount: _reviewList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index){
              return _newCard(ReviewData.fromJson(_reviewList[index].data()), index);
              }
          );
        }
    );
  }

  Future<String> getProfileUrlByUid(String uid) {
    DocumentReference _userRef = FirebaseFirestore.instance.collection('User').doc(uid);
    return _userRef.get().then((value) {
      Map<String, dynamic> _json =  value.data();
      return _json['profileImageURL'];
    });
  }

  Future<String> getNicknameByUid(String uid){
    DocumentReference _userRef = FirebaseFirestore.instance.collection('User').doc(uid);
    return _userRef.get().then((value) {
      Map<String, dynamic> _json =  value.data();
      return _json['nickname'];
    });
  }


  Widget _newCard(ReviewData reviewData, int index) {

    String getReviewDateTime(){
      Duration diff = DateTime.now().difference(reviewData.updateTime);

      if(diff.compareTo(Duration(minutes: 1)) < 0){
        return diff.inSeconds.toString() + '초전';
      }
      else if(diff.compareTo(Duration(hours: 1)) < 0){
        return diff.inMinutes.toString() + '분전';
      }
      else if(diff.compareTo(Duration(days: 1)) < 0){
        return diff.inHours.toString() + '시간전';
      }
      else if(diff.compareTo(Duration(days: 7)) < 0){
        return diff.inDays.toString() + '일전';
      }
      else if(diff.compareTo(Duration(days: 30)) < 0){
        return (diff.inDays~/7).toString() + '주전';
      }
     else if(diff.compareTo(Duration(days: 365)) < 0){
        return (diff.inDays~/30).toString() + '달전';
      }
     else return (diff.inDays~/365).toString() + '년전';
    }

    return FutureBuilder(
      future: Future.wait([getProfileUrlByUid(reviewData.uid),getNicknameByUid(reviewData.uid)]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 2, //그림자 깊이
              margin: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.withOpacity(0.6),
                          backgroundImage:
                          Image.network(snapshot.data[0].toString())
                              .image,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data[1].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                  rating: reviewData.starScore,
                                  itemCount: 5,
                                  direction: Axis.horizontal,
                                  itemSize: 15,
                                  itemBuilder: (context, index) {
                                    return Icon(
                                      Icons.star,
                                      color: Color(mainColor),
                                    );
                                  }),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                getReviewDateTime(),
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey.shade600),
                              )
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context) {
                          return [PopupMenuItem<int>(value: 1, child: Text('신고하기'))];
                        },
                        onSelected: (value) {
                          if (value == 1) {
                            print('신고하기');
                          }
                        },
                      ),
                    ],
                  ),
                  reviewData.reviewImageUrl.length > 0 ?  slidingImageViewer(reviewData.reviewImageUrl,index) : Container(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Text(reviewData.mainText, style: TextStyle(fontSize: 15),),
                  )
                ],
              ),
            ),
          );
        }
        else return Container();
        }
    );
  }

  Widget slidingImageViewer(List<dynamic> _reviewImages, int index){
    final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
            items: _reviewImages.map(
                    (url) => Container(
                      decoration: BoxDecoration(
                          border: Border(), borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        )
                    )
            ).toList(),
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              aspectRatio: 1,
              autoPlay: false,
              onPageChanged: (num,reason){
                _currentIndexNotifier.value = num;
              }
            )
        ),
        Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child:Container(
                      width: 50,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.4),
                          borderRadius: BorderRadius.all(
                              Radius.circular(30))),
                      child: Center(
                          child: ValueListenableBuilder(
                            valueListenable: _currentIndexNotifier,
                            builder: (BuildContext context, int value, Widget child){
                              return RichText(
                                text: TextSpan(
                                    text: '${_currentIndexNotifier.value + 1} ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                    children: [
                                      TextSpan(
                                          text:
                                          '/ ${_reviewImages.length}',
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.normal))
                                    ]
                                ),
                              );
                            },
                          )
                      )
                  ),
                )
              ],
            )
        )
      ],
    );
  }
}
