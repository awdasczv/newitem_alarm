import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';

import './Comment_listItem.dart';

class Comment extends StatefulWidget {
  final NewGoods goods;

  const Comment({Key key, this.goods}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  bool _isReply = false;
  String goodsID;

  // String goodsID = NewGoods.fromJson();
  CollectionReference goodsRef = FirebaseFirestore.instance.collection('Goods');
  final auth = FirebaseAuth.instance;

  getGoodsID(@required goods_title) {
    goodsRef
        .where("title", isEqualTo: goods_title) //비동기라서...시간이 오래 걸려서..??
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
              final goodsID = element.reference.id.toString();
              return goodsID;
            }));
  }

  userName() {
    final user = auth.currentUser;
    if (user != null) {
      final user_name = user.displayName.toString();
      return user_name;
    }
  }

  userProfile() {
    final user = auth.currentUser;
    if (user != null) {
      final user_profile = user.photoURL;
      return user_profile;
    }
  }

  userID() {
    final user = auth.currentUser;
    if (user != null) {
      final user_id = user.uid;
      return user_id;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    _focusNode.requestFocus();
    FocusScope.of(context).unfocus();
    Map<String, dynamic> data = {
      'text': text,
      'dateTime': Timestamp.now(),
      'userName': userName(),
      'userProfileUrl': userProfile(),
      'userID': userID(),
      'like': 0,
      'likedBy': [],
      'goodsID': widget.goods.id
    };
    setState(() async {
      _isComposing = false;
      CollectionReference commentRef =
          //왜 widget.goods.id로 하면 되고, 왜 id 받아서 하면 안될까,,,?
          goodsRef.doc(widget.goods.id).collection('Comment');
      //total 나중에 사용할 수도 있을 것 같아 남겨둠.
      var total = await commentRef
          .get()
          .then((value) => value.docs.asMap().keys.length);

      commentRef.doc('metadata').set({'total': total, 'delete + total': 0});

      String index = '';
      if (_i < 10) {
        index = '00' + _i.toString();
      } else if (_i < 100) {
        index = '0' + _i.toString();
      } else {
        index = _i.toString();
      }

      String commentID = widget.goods.id + "-01-" + index;

      commentRef
          .doc(commentID)
          .set(data)
          .then((value) => print('Comment Upload'))
          .catchError((error) {
        return print('댓글 입력 오류: $error'); //문제가 발생하면 오류 출력
      });
      commentRef.doc(commentID).update({'commentID': commentID});
    });
  }

  int _i = 0;

  void add() {
    setState(() {
      _i++;
    });
  }

  Widget _buildcommentList() {
    CollectionReference commentRef =
        goodsRef.doc(widget.goods.id).collection('Comment');
    return StreamBuilder<QuerySnapshot>(
        stream: commentRef.orderBy('dateTime', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xffFFC845))),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final commentDocs = snapshot.data.docs;
          //snapshot.date!.docs 안됨..
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < commentDocs.length)
                  return Column(
                    children: [
                      commentListItem(
                        commentDocs[index]['userProfileUrl'],
                        commentDocs[index]['userName'],
                        commentDocs[index]['dateTime'],
                        commentDocs[index]['text'],
                        commentDocs[index]['userID'],
                        commentDocs[index]['like'],
                        commentDocs[index]['likedBy'],
                        commentDocs[index].reference,
                      ),
                    ],
                  );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [_buildcommentList()],
          ),
          bottomNavigationBar:
          buildInput(_isReply == false ? '댓글을 입력해주세요.' : ' 답글을 입력해주세요.'),
        ));
  }

  Future<void> commentCount() async {
    String id = getGoodsID(widget.goods.title);
    CollectionReference commentRef = goodsRef.doc(id).collection('Comment');
    final comment = await commentRef.get();
    WriteBatch batch = FirebaseFirestore.instance.batch();
  }

  Widget buildInput(@required String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width - 70,
              child: Expanded(
                child: TextField(
                  // scrollPadding: EdgeInsets.all(3),
                  maxLines: null,
                  //자동으로 줄바꿈
                  keyboardType: TextInputType.multiline,
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Color(0xffFFC845),
                  cursorWidth: 3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 15, right: 10, top: 10, bottom: 10),
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  onSubmitted: _isComposing ? _handleSubmitted : null,
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.trim().isNotEmpty;
                    });
                  },
                ),
              )),
          CircleAvatar(
              backgroundColor: Color(0xffFFC845),
              radius: 20,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                  color: Colors.white,
                ),
                onPressed: _isComposing
                    ? () {
                        if (userName() != null) {
                          add();
                          _handleSubmitted(_textEditingController.text);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    '댓글 작성',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content:
                                      Text('로그인이 필요한 서비스입니다. 로그인 후 이용해주세요.'),
                                  actions: [],
                                );
                              });
                        }
                        //method 뒤에 ()가 있다는 것은 method가 실행되며, method 값이 리턴된다는 의미, ()가 없다면, 위치를 참조
                      }
                    : null,
              ))
        ],
      ),
    );
  }
}
