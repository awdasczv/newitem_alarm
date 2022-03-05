import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newitem_alarm/GoodsPages/MukTV.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';
import 'package:newitem_alarm/model/goods.dart';

import './comment/Comment.dart';
import './review/Review.dart';
import './review/WritingReview.dart';
import '../model/Favorite_button.dart';
import 'bar_chart.dart';

class GoodsDetailHome extends StatefulWidget {
  final NewGoods goods;

  const GoodsDetailHome({Key key, @required this.goods}) : super(key: key);

  @override
  _GoodsDeatilHomeState createState() => _GoodsDeatilHomeState();
}

class _GoodsDeatilHomeState extends State<GoodsDetailHome> {
  final mainColor = Color(0xffFFC845);
  int currentimage = 0;
  int currentIndex = 0;
  final bar = ['댓글', '리뷰', '먹TV'];
  final CarouselController _carouselController = CarouselController();

  bool buttonStyle = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  print(widget.goods.starScore);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: DefaultTabController(
            length: bar.length,
            child: NestedScrollView(
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    buildSliverAppBar(context),
                    buildSliverToBoxAdapter(),
                    buildSliverToBoxAdapter2(context),
                    SliverPersistentHeader(
                      delegate: TabSliverDelegate(TabBar(
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: mainColor),
                        labelColor: Colors.white,
                        unselectedLabelColor: mainColor,
                        labelStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                        labelPadding: EdgeInsets.symmetric(horizontal: 20),
                        tabs: bar
                            .map((e) => Tab(
                                  text: e,
                                ))
                            .toList(),
                      )),
                      pinned: true,
                    )
                  ];
                },
                body: TabBarView(
                  children: [Comment(), ReviewPage(goods: widget.goods), MukTV()],
                )
            )
        ),
      ),
    );
  }

  SliverToBoxAdapter buildSliverToBoxAdapter2(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: 270,
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, //Row일 때 왼쪽으로 정렬
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
                      "(${widget.goods.reviewNum.toString()}개)",
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
                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                              itemCount: 5,
                              itemSize: 15,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Container(
                          width: 2,
                          height: 120,
                          color: Colors.grey[200],
                        ),
                        //여기서는 VerticalDivider()보다 Container()사용하는 게 더 편함.
                        /*Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              rating: 3.5,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return Container(
                                      width: 10,
                                      height: 150,
                                      color: Colors.purple,
                                    );
                                  case 1:
                                    return Container(
                                      width: 3,
                                      height: 70,
                                      color: Colors.green,
                                    );
                                  case 2:
                                    return Container(
                                      width: 3,
                                      height: 70,
                                      color: Colors.deepOrange,
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
                        ),*/
                        ProductReview()
                      ],
                    )),
             //   const Padding(padding: EdgeInsets.only(bottom: 10)),

                TextButton(
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
                    ))
              ],
            ),
          )),
    );
  }

  SliverToBoxAdapter buildSliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          //height: 500,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12, left: 15, bottom: 5),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, //Column일 때 왼쪽 정렬
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text(
                                widget.goods.brand,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.goods.title,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.goods.price.toString() + "원",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('출시일 ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          widget.goods.launchdate.substring(0, 2) +
                              "년 " +
                              widget.goods.launchdate.substring(2, 4) +
                              "월 ",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    buttonStyle == false ? Nutrient1() : Nutrient2(),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget Nutrient1() {
    return Row(
      children: [
        Text(
          '영양성분',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600),
        ),
        // const SizedBox(
        //   width: 15,
        // ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded),
          iconSize: 15,
          onPressed: () {
            setState(() {
              buttonStyle = !buttonStyle;
            });
          },
          //추후에 영양성분 api랑 연결해서 정보 뜨게 만들기!

        ),
        //Nutrient(),
      ],
    );
  }

  Widget Nutrient2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('영양성분', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w600),),
            // const SizedBox(
            //   width: 15,
            // ),
            IconButton(
              icon: Icon(Icons.keyboard_arrow_down_sharp),
              iconSize: 25,
              onPressed: () {
                setState(() {
                  buttonStyle = !buttonStyle;
                });
              },
              //추후에 영양성분 api랑 연결해서 정보 뜨게 만들기!
            ),
          ],
        ),
        Text( '가나다라마바사akefeihjaie라더먀더ㅑ처파ㅓ미ㅏ어먀ㅐ더마ㅓㅜㅊ낲미ㅏ괘먀ㅙㅏ춮먀ㅗㄷ개먀니차ㅓㅍ먀거매ㅑㅜ내먀ㅙ먀ㅗㅓㅐㅑ더', style: TextStyle( fontSize: 14, fontWeight: FontWeight.w600), ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        )
      ],
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      expandedHeight: 320,
      //AppBar의 최대 높이
      backgroundColor: Colors.white,
      pinned: true,
      //스크롤 내렸을 때 상단 AppBar 고정 true
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
        ),
        iconSize: 30,
        tooltip: 'Back Icon',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        FavoriteButton(
          iconSize: 50,
          iconDisabledColor: Colors.black,
          isFavorite: false,
          valueChanged: (_isFavorite) {
            print('Is Favorite : $_isFavorite');
          },
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share_rounded),
          iconSize: 30,
        ),
        const SizedBox(
          width: 7,
        )
      ],
      flexibleSpace: Hero(
        tag: widget.goods.title,
        child: LayoutBuilder(builder: (context, constraints) {
          double height = constraints.biggest.height;
          // print(height);
          return FlexibleSpaceBar(
              title: height < 60
                  ? Text(
                      widget.goods.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )
                  : null,
              background: widget.goods.imageURL.length > 1
                  ? Stack(
                      children: [
                        CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                              height: 320,
                              viewportFraction: 1,
                              //각 페이지가 보이는 영역 비율
                              autoPlay: false,
                              //자동으로 page넘김
                              enlargeCenterPage: true,
                              // enlargeStrategy: CenterPageEnlargeStrategy
                              //     .height, //센터에 있는 page를 확대하는 방법
                              //aspectRatio: 1, height 선언되지 않을 때 사용
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentimage = index;
                                });
                              }),
                          items: widget.goods.imageURL.map((img) {
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(img),
                                fit: BoxFit.fill,
                              )),
                            );
                          }).toList(),
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
                                  child: Container(
                                      width: 50,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Center(
                                          child: RichText(
                                        text: TextSpan(
                                            text: '${currentimage + 1} ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '/ ${widget.goods.imageURL.length}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal))
                                            ]),
                                      ))),
                                )
                              ],
                            )),
                      ],
                    )
                  : Stack(
                      children: [
                        Container(
                          height: 320,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.goods.imageURL[0]),
                                  fit: BoxFit.fill)),
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
                                  child: Container(
                                      width: 50,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Center(
                                          child: RichText(
                                        text: TextSpan(
                                            text: '${currentimage + 1} ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      '/ ${widget.goods.imageURL.length}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal))
                                            ]),
                                      ))),
                                )
                              ],
                            ))
                      ],
                    ));
        }),
      ),
    );
  }
}

class TabSliverDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  TabSliverDelegate(@required this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final mainColor = Color(0xffFFC845);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


/*
RatingBarIndicator(
                          rating: 3.5,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return Column(
                                  children: [
                                  Container(
                                    width: 10,
                                    height: 150,
                                    color: Colors.purple,
                                  ),
                                  Text("5점", style: TextStyle(fontSize: 100)),
                                  ],
                                );
                              case 1:
                                return Container(
                                  width: 3,
                                  height: 70,
                                  color: Colors.green,
                                );
                              case 2:
                                return Container(
                                  width: 3,
                                  height: 70,
                                  color: Colors.deepOrange,
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
 */