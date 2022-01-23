import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newitem_alarm/GoodsPages/Comment.dart';
import 'package:newitem_alarm/model/goods.dart';

class WritingReview extends StatefulWidget {
  final Goods goods;

  const WritingReview({Key key, this.goods}) : super(key: key);

  @override
  _WritingReviewState createState() => _WritingReviewState();
}

class _WritingReviewState extends State<WritingReview> {

  final mainColor = 0xfff1c40f;
  final _tc = TextEditingController();
  ReviewData _reviewData;

  @override
  void initState() {
    // TODO: implement initState
    _reviewData = ReviewData(
      profileImageUrl: 'templink',
      nickname: '임시',
      starScore: 3.0,
      reviewImageUrl: '',
      mainText: ''
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
             Row(
               children: [
                 IconButton(
                   icon: Icon(
                     Icons.arrow_back_ios_rounded,
                     color: Colors.black87,
                   ),
                   iconSize: 30,
                   onPressed: () {
                     Navigator.pop(context);
                   },
                 ),
                 Spacer(),
                 TextButton(
                     onPressed: (){},
                     child: Text('완료',style: TextStyle(color: Colors.black,fontSize: 17),)
                 )
               ],
             ),
              Text(widget.goods.title),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _reviewData.starScore = rating;
                },
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade200,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                    minHeight: 300
                  ),
                  child: TextField(
                    controller: _tc,
                    keyboardType: TextInputType.multiline,
                    maxLines: 300,
                    cursorColor: Colors.black,
                  ),
                )
              )
            ],
          )
      ),
    );
  }
}
