import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './Comment_listItem.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  bool _isReply = false;
  CollectionReference commentRef =
      FirebaseFirestore.instance.collection('comment');
  final auth = FirebaseAuth.instance;

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
    setState(() {
      _isComposing = false;
      commentRef
          .add({
            'text': text,
            'dateTime': Timestamp.now(),
            'userName': userName(),
            'userProfileUrl': userProfile(),
            'userID': userID(),
            'like': 0,
            'likedBy': []
          })
          .then((value) => print(value.id))
          .catchError((error) {
            return print('댓글 입력 오류: $error'); //제대로 추가되면 id 출력하고, 문제가 발생하면 오류 출력
          });
    });
  }

  Widget _buildcommentList() {
    return StreamBuilder<QuerySnapshot>(
        stream: commentRef.orderBy('dateTime', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xfff1c40f))),
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
                if (index < commentDocs.length) {
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
                          commentDocs[index].reference),
                    ],
                  );
                }
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Stack(children: [
              Column(
                children: [
                  _buildcommentList(),
                  buildInput(
                      _isReply == false ? ' 댓글을 입력해주세요.' : ' 답글을 입력해주세요.')
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }

  Container buildInput(@required String hintText) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xfff1c40f).withOpacity(.09))
      ]),
      child: Padding(
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
                    maxLines: null,
                    //자동으로 줄바꿈
                    keyboardType: TextInputType.multiline,
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Color(0xfff1c40f),
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
                backgroundColor: Color(0xfff1c40f),
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: _isComposing
                      ? () {
                          _handleSubmitted(_textEditingController.text);
                          //method 뒤에 ()가 있다는 것은 method가 실행되며, method 값이 리턴된다는 의미, ()가 없다면, 위치를 참조
                        }
                      : null,
                ))
          ],
        ),
      ),
    );
  }
}
