import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './Comment_listItem.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  TextEditingController _textEditingController = TextEditingController();
  StreamSubscription _streamSubscription;
  FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  bool _isReply = false;
  ScrollController _controller = ScrollController();
  final auth = FirebaseAuth.instance;

  @override
  userName() {
    final user = auth.currentUser;
    if (user != null) {
      final user_name = user.displayName.toString();
      return user_name;
    }
  }

  @override
  userProfile() {
    final user = auth.currentUser;
    if (user != null) {
      final user_profile = user.displayName.toString();
      return user_profile;
    }
  }

  @override
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
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void _handleSubmitted(String text) {
    _textEditingController.clear();
    _focusNode.requestFocus();
    FocusScope.of(context).unfocus();
    setState(() {
      _isComposing = false;
      FirebaseFirestore.instance.collection('comment').add({
        'text': text,
        'dateTime': Timestamp.now(),
        'userName': userName(),
        'userProfileUrl': userProfile(),
        'userID': userID(),
      });
    });
  }

  Widget _buildcommentList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('comment')
            .orderBy('dateTime', descending: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xfff1c40f))),
            );
          }
          final commentDocs = snapshot.data.docs;
          //snapshot.date!.docs 안됨..
          return ListView.builder(
              controller: _controller,
              itemBuilder: (context, index) {
                if (index < commentDocs.length) {
                  return commentListItem(
                      commentDocs[index]['userProfileUrl'],
                      commentDocs[index]['userName'],
                      commentDocs[index]['dateTime'],
                      commentDocs[index]['text'],
                      commentDocs[index]['userID']);
                }
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Column(
              children: [
                Expanded(child: _buildcommentList()),
                const Divider(
                  height: 1,
                ),
                buildInput(' 댓글을 적어주세요.')
              ],
            ),
          ])),
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
