import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';

import '../../model/goods.dart';
import 'review/WritingReview.dart';

class Top extends StatefulWidget {
  final Goods goods; //goods.dart에 있는 Goods 객체 넘겨받기
  const Top({Key key, @required this.goods}) : super(key: key);

  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  int _currentimage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Stack(
              overflow: Overflow.visible, //overflow된 child 보이게
              fit: StackFit.loose, //Stack에서 Positioned 안된 child 크기 조정(loose하게)
              // alignment: Alignment.center,
              children: [
                CarouselSlider(
                  items: [widget.goods.imageUrl[0], widget.goods.imageUrl[1]]
                      .map((item) {
                    return Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.network(item),
                              ),
                            ))); //ClipRect : Clips the image in rectangle //ClipRRect : Clips the image in circle
                  }).toList(),
                  options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1.0,
                      //각 페이지가 보이는 영역 비율
                      autoPlay: false,
                      //자동으로 page넘김
                      enlargeCenterPage: true,
                      // enlargeStrategy: CenterPageEnlargeStrategy
                      //     .height, //센터에 있는 page를 확대하는 방법
                      //aspectRatio: 1, height 선언되지 않을 때 사용
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentimage = index;
                        });
                      }),
                ),
                Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 29.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [widget.goods.imageUrl[0], widget.goods.imageUrl[1]]
                          .map((url) {
                        int index = [
                          widget.goods.imageUrl[0],
                          widget.goods.imageUrl[1],
                        ].indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentimage == index
                                  ? Colors.black26
                                  : Colors.black),
                        );
                      }).toList(),
                    )),
                Positioned.fill(
                    bottom: -MediaQuery.of(context).size.height * .3, //기기 세로사이즈 받기
                    // top: MediaQuery.of(context).size.height * .50,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 220,
                              width: MediaQuery.of(context).size.width * .94,
                              //기기 가로사이즈 // MediaQuery.of(context).size.width
                              child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 12, left: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, //Column일 때 왼쪽 정렬
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {},
                                                    //brand 상품 보이는 화면 만들기...?
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black12,
                                                              blurRadius: 3.0,
                                                            )
                                                          ]),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                        Colors.transparent,
                                                        radius: 25,
                                                        backgroundImage:
                                                        NetworkImage(widget
                                                            .goods.brandlogo),
                                                      ),
                                                    )),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    widget.goods.title,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    overflow: TextOverflow.visible,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.goods.price.toString() + "원",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 15,
                                        thickness: 1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10, left: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('출시일 ',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w600)),
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                Text(
                                                  widget.goods.launchdate
                                                      .substring(0, 4) +
                                                      "년 " +
                                                      widget.goods.launchdate
                                                          .substring(4, 6) +
                                                      "월 " +
                                                      widget.goods.launchdate
                                                          .substring(6, 8) +
                                                      "일",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '영양성분',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                // const SizedBox(
                                                //   width: 15,
                                                // ),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: IconButton(
                                                      onPressed: () {},
                                                      //추후에 영양성분 api랑 연결해서 정보 뜨게 만들기!
                                                      icon: Icon(Icons
                                                          .arrow_forward_ios_sharp),
                                                      iconSize: 15,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ))),
                        )))
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .32),
            Card(
              elevation: 5,
              color: Colors.white,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 210,
                  width: MediaQuery.of(context).size.width * .94,
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start, //Row일 때 왼쪽으로 정렬
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              '신상품 리뷰',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "(${widget.goods.total_review_count.toString()}개)",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black26),
                            )
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center, //Column일 때 가운데 정렬
                                  children: [
                                    Text(
                                      widget.goods.starScore.toString(),
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    RatingBarIndicator(
                                      rating: widget.goods.starScore,
                                      itemBuilder: (context, index) {
                                        return Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        );
                                      },
                                      itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                      itemCount: 5,
                                      itemSize: 25,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 100,
                                  color: Colors.black12,
                                ),
                                //여기서는 VerticalDivider()보다 Container()사용하는 게 더 편함.
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBarIndicator(
                                      rating: widget.goods.starScore,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Container(
                                              width: 10,
                                              height: 150,
                                              color: Colors.black26,
                                            );
                                          case 1:
                                            return Container(
                                              width: 3,
                                              height: 70,
                                              color: Colors.black26,
                                            );
                                          case 2:
                                            return Container(
                                              width: 3,
                                              height: 70,
                                              color: Colors.black26,
                                            );
                                          case 3:
                                            return Container(
                                              width: 3,
                                              height: 70,
                                              color: Colors.black26,
                                            );
                                          case 4:
                                            return Container(
                                              width: 3,
                                              height: 70,
                                              color: Colors.black26,
                                            );
                                        }
                                      },
                                      itemCount: 5,
                                      itemSize: 30,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        /*TextButton(
                            onPressed: () {},
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WritingReview(
                                          goods: widget.goods,
                                        )));
                              },
                              child: Text(
                                '리뷰 작성하러 가기',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueAccent),
                              ),
                            )
                        )*/
                      ],
                    ),
                  )),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
          ],
        ));
  }
}
// CircleAvatar(
// radius: 25,
// backgroundColor:
// Colors.black12,
// child: CircleAvatar(
// radius: 24,
// backgroundImage:
// NetworkImage(widget
//     .goods.brandlogo),
// ),
// )
