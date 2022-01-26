import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
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
  final _nickNameTc = TextEditingController();

  ReviewData _reviewData;
  XFile _uploadImage;
  XFile _tempUploadImage;
  bool _success_get_image = false;
  bool _temp_success_get_image = false;

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
          child: ListView(
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
                height: MediaQuery.of(context).size.height * 2 / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade200,
                ),
                child:TextField(
                  controller: _tc,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.black,
                  maxLength: 300,
                  maxLines: 50,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'mainText'
                  ),
                ),
              ),
             Padding(
               padding:  EdgeInsets.fromLTRB(10, 10, 10, 10),
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   InkWell(
                     child: Container(
                       height: 50,
                       width: 50,
                       color: Colors.grey.shade200,
                       margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                       child: Icon(Icons.image),
                     ),
                     onTap: () async{
                       var _image = await ImagePicker().pickImage(source: ImageSource.gallery);
                       if(_image != null){
                         setState(() {
                           _uploadImage = _image;
                           _success_get_image = true;
                         });
                       }
                     },
                   ),
                   _success_get_image == true ?
                       Container(
                         height: 50,
                         width: 50,
                         child: Image.file(File(_uploadImage.path),fit: BoxFit.cover),
                       ) :
                       Container()
                 ],
               ),
             ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _nickNameTc,
                  decoration: InputDecoration(
                    hintText: '임시 닉네임 적어두는곳'
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 100,
                        color: Colors.grey.shade200,
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text('임시프로필이미지 가져오는곳'),
                      ),
                      onTap: () async{
                        var _image = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(_image != null){
                          setState(() {
                            _tempUploadImage = _image;
                            _temp_success_get_image = true;
                          });
                        }
                      },
                    ),
                    _temp_success_get_image == true ?
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.file(File(_tempUploadImage.path),fit: BoxFit.cover),
                    ) :
                    Container()
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
