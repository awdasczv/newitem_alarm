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
  final _nickNameTc = TextEditingController();

  double _imageBoxLength;

  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";

  void _prepareService() async {
    _user = _firebaseAuth.currentUser;
  }

  TempReviewData _reviewData;
  XFile _uploadImage;
  bool _success_get_image = false;

  List<XFile> _uploadImageList = [];

  XFile _tempUploadImage;
  bool _temp_success_get_image = false;

  @override
  void initState() {
    // TODO: implement initState
    _reviewData = TempReviewData(
        profileImageUrl: 'templink',
        nickname: '임시',
        starScore: 3.0,
        reviewImageUrl: '',
        mainText: ''
    );
    _prepareService();


    super.initState();
  }

  Future<void> _uploadReview() async{
    if(_success_get_image == false && _tc.text.length < 1){
      return;
    }

     var documentSnapshot = await FirebaseFirestore.instance.collection('Goods').doc(widget.goods.id).get();


     int _reviewNum = documentSnapshot.data()["reviewNum"] + 1;

     String _reviewId = widget.goods.id + '-02-' + _reviewNum.toString();


     List<File> _tempUploadFile = List.generate(_uploadImageList.length, (index) => File(_uploadImageList[index].path));

     for(int i = 0 ; i < _tempUploadFile.length ; i++){
       //사진 경로 설정
       Reference ref = _firebaseStorage.ref().child("reviewImage/${widget.goods.id}/${_reviewId.toString()}/${i.toString()}");

       // 사진 업로드
       UploadTask  storageUploadTask = ref.putFile(_tempUploadFile[i]);
       // 파일 업로드 완료까지 대기
       await storageUploadTask.whenComplete(() => null);

       // 업로드한 사진의 URL 획득
       String downloadURL = await ref.getDownloadURL();
     }

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
                      child: Text('완료',style: TextStyle(color: Colors.black,fontSize: 17),
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
                        _reviewData.starScore = rating;
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
                            _uploadImage = _image.first;
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
              /*
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
                        // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
                        Reference ref = _firebaseStorage.ref().child("reviewImage/${widget.goods.id}/profileImage");

                        // 파일 업로드
                        File _tempFile = File(_tempUploadImage.path);
                        UploadTask  storageUploadTask = ref.putFile(_tempFile);

                        // 파일 업로드 완료까지 대기
                        await storageUploadTask.whenComplete(() => null);

                        // 업로드한 사진의 URL 획득
                        String downloadURL = await ref.getDownloadURL();

                        // 업로드된 사진의 URL을 페이지에 반영
                        setState(() {
                          _profileImageURL = downloadURL;
                        });
                        print(_profileImageURL);
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
              ),*/
            ],
          )
      ),
    );
  }

  void uploadNewGoods() async{
    //다양한 카테고리 데이터를 업로드 해주세요!!

    NewGoods newGoods = NewGoods(
      brand: "스타벅스",
      title: "스노우 민트 초콜릿 블렌디드",
      price: 6300, //가격  숫자로 넣어주기
      launchdate: "2112", //launchdate는 출시 일자인데 연도 + 월 입니다 ex) 21년 9월출시 -> "2109"(String입니다)
      starScore: 3, //starscore는 1~5 사이의 실수값을 넣어주세요
      reviewNum: 0,//얘는 0으로 놔두기
      category: 4, //category 번호는 아래 Map<int,String> category 을 참고해주세요
      imageURL: ["https://img.insight.co.kr/static/2021/12/08/700/img_20211208174745_80xb0gwn.webp"]
    );

    newGoods.uploadNewGoods();


  }

  Map<int,String> category = {
    1 : '젤리/초콜릿',
    2 : '빵집',
    3 : '음료',
    4 : '카페/디저트',
    5 : '주류',
    6 : '라면',
    7 : '햄버거',
    8 : '피자',
    9 : '치킨',
    10 : '즉석/냉동',
    11 : '아이스크림',
    12 : '과자'
  };
}
