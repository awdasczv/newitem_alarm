import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newitem_alarm/GoodsPages/review/Review.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';
import 'package:newitem_alarm/model/goods.dart';

class WritingReview extends StatefulWidget {
  final NewGoods goods;

  const WritingReview({Key key, this.goods}) : super(key: key);

  @override
  _WritingReviewState createState() => _WritingReviewState();
}

class _WritingReviewState extends State<WritingReview> {

  final mainColor = 0xfff1c40f;
  final _tc = TextEditingController();

  double _imageBoxLength;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  CollectionReference reviewRef;
  DocumentReference goodsRef;


  bool _success_get_image = false;

  List<XFile> _uploadImageList = [];

  double _starScore = 3;
  List<String> _reviewImageUrlForFirebase = [];
  
  @override
  void initState() {
    // TODO: implement initState
    _user = _firebaseAuth.currentUser;
    
    reviewRef = FirebaseFirestore.instance.collection('Goods').doc(widget.goods.id).collection('Review');
    goodsRef = FirebaseFirestore.instance.collection('Goods').doc(widget.goods.id);

    super.initState();
  }


  Future<void> _uploadReview() async{

    final ValueNotifier<int> _counter = ValueNotifier<int>(0);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState){
                return AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child:ValueListenableBuilder(
                          valueListenable: _counter,
                          builder: (BuildContext context, int value, Widget child){
                            if(_uploadImageList.length < 1){
                              return Text('????????????...    ',style: TextStyle(fontSize: 15),);
                            }
                            return  Text('????????? ????????????...   ' + (value+1).toString() + '/' + _uploadImageList.length.toString(),
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            );
                          },
                        )
                      )
                    ],
                  ),
                );
              }
          );
        }
    );

    if(_success_get_image == false && _tc.text.length < 1){
      Navigator.pop(context);
      return;
    }

    var documentSnapshot = await FirebaseFirestore.instance.collection('Goods').doc(widget.goods.id).get();
    var reviewRateDocumentSnapshot = await FirebaseFirestore.instance.collection('Goods').doc(widget.goods.id).collection('ReviewRate').doc('ReviewRate').get();
    DocumentReference reviewRateRef = FirebaseFirestore.instance.collection('Goods').doc(widget.goods.id).collection('ReviewRate').doc('ReviewRate');
    
    int _reviewNum = documentSnapshot.data()["reviewNum"] + 1;

    String _reviewId = widget.goods.id + '-02-' + _reviewNum.toString();

    List<File> _tempUploadFile = List.generate(_uploadImageList.length, (index) => File(_uploadImageList[index].path));

    void _uploadImage() async{
      //?????? ?????? ??????
      Reference ref = _firebaseStorage.ref().child("reviewImage/${widget.goods.id}/${_reviewId.toString()}/${_counter.value.toString()}");

      // ?????? ?????????
      UploadTask  storageUploadTask = ref.putFile(_tempUploadFile[_counter.value]);
      // ?????? ????????? ???????????? ??????
      await storageUploadTask.whenComplete(() => null);

      // ???????????? ????????? URL ??????
      String downloadURL = await ref.getDownloadURL();

      _reviewImageUrlForFirebase.add(downloadURL);
    }

    for(_counter.value = 0 ; _counter.value < _tempUploadFile.length - 1; _counter.value++){
      _uploadImage();
    }
    if(_tempUploadFile.length > 0){_uploadImage();}



    print(reviewRateDocumentSnapshot.data()[_starScore.toInt().toString()] );

    reviewRateRef.update({_starScore.toInt().toString() : reviewRateDocumentSnapshot.data()[_starScore.toInt().toString()] + 1});


    reviewRef.doc(_reviewId).set({
      'uid':_user.uid,
      'reviewId' : _reviewId,
      'starScore' : _starScore,
      'mainText': _tc.text,
      'goodsId' : widget.goods.id,
      'updateTime' : Timestamp.now(),
      'reviewImageUrl' : _reviewImageUrlForFirebase
    });

    goodsRef.update({
      'reviewNum' : _reviewNum
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _imageBoxLength = MediaQuery.of(context).size.width/6;

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
                      onPressed: ()async{
                        await _uploadReview();
                        Navigator.pop(context);
                      },
                      child: Text('??????',style: TextStyle(color: Colors.black,fontSize: 17),
                      )
                  )
                ],
              ),
              Center(
                child: Column(
                  children: [
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
                        _starScore = rating;
                      },
                    ),
                  ],
                ),
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
                        height:_imageBoxLength,
                        width:_imageBoxLength,
                        color: Colors.grey.shade200,
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.image),
                            Text(_uploadImageList.length.toString() + '/4')
                          ],
                        ),
                      ),
                      onTap: () async{
                        var _image = await ImagePicker().pickMultiImage();
                        if(_image != null){
                          setState(() {
                            if(_image.length > 4){
                              _uploadImageList = _image.sublist(0,4);
                            }
                            else _uploadImageList = _image;
                            _success_get_image = true;
                          });
                        }
                      },
                    ),
                    _success_get_image == true ?
                    Expanded(
                        child: Container(
                          height: _imageBoxLength,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _uploadImageList.length,
                              itemBuilder: (BuildContext context,int index){
                                return Container(
                                  height:_imageBoxLength,
                                  width: _imageBoxLength,
                                  child: Image.file(File(_uploadImageList[index].path),fit: BoxFit.cover),
                                );
                              },
                            separatorBuilder: (BuildContext context, int index){
                                return SizedBox(width: 10,);
                            },
                          ),
                        )
                    ):
                    Container()
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  void uploadNewGoods() async{
    //????????? ???????????? ???????????? ????????? ????????????!!

    NewGoods newGoods = NewGoods(
      brand: "????????????",
      title: "????????? ?????? ????????? ????????????",
      price: 6300, //??????  ????????? ????????????
      launchdate: "2112", //launchdate??? ?????? ???????????? ?????? + ??? ????????? ex) 21??? 9????????? -> "2109"(String?????????)
      starScore: 3, //starscore??? 1~5 ????????? ???????????? ???????????????
      reviewNum: 0,//?????? 0?????? ?????????
      category: 4, //category ????????? ?????? Map<int,String> category ??? ??????????????????
      imageURL: ["https://img.insight.co.kr/static/2021/12/08/700/img_20211208174745_80xb0gwn.webp"]
    );

    newGoods.uploadNewGoods();
  }

  Map<int,String> category = {
    1 : '??????/?????????',
    2 : '??????',
    3 : '??????',
    4 : '??????/?????????',
    5 : '??????',
    6 : '??????',
    7 : '?????????',
    8 : '??????',
    9 : '??????',
    10 : '??????/??????',
    11 : '???????????????',
    12 : '??????'
  };
}

