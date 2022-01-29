import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    setState(() {
      _isComposing = false;
      FirebaseFirestore.instance.collection('comment').add({
        'text': text,
        'dateTime': Timestamp.now(),
        'userName': userName(),
        'userProfileUrl': userProfile(),
      });
    });
    _focusNode.requestFocus();
    FocusScope.of(context).unfocus();
  }

  Widget _buildcommentList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('comment')
            .orderBy('dateTime', descending: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xfff1c40f))),
            );
          }
          final commentDocs = snapshot.data.docs; //snapshot.date!.docs 안됨..
          return ListView.builder(itemBuilder: (context, index) {
            if (index < commentDocs.length) {
              return _buildListItem(commentDocs, index, context);
            }
          });
        });
  }

  Container _buildListItem(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> commentDocs,
      int index,
      BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundImage: commentDocs[index]['userProfileUrl'] == null
                  ? AssetImage('assets/images/default_profile.png')
                  : NetworkImage(commentDocs[index]['userProfileUrl']),
              radius: 20,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        commentDocs[index]['userName'] == null
                            ? '비회원'
                            : commentDocs[index]['userName'],
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                      Text(' · '),
                      Text(
                        DateFormat('MM/dd HH:mm')
                            .format(commentDocs[index]['dateTime'].toDate())
                            .toString(),
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width * .8,
                    child: Text(
                      commentDocs[index]['text'],
                      style: TextStyle(fontSize: 15),
                    )),
                Row(
                  children: [
                    InkResponse(
                      child: Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 17,
                      ),
                      highlightColor: Colors.blue,
                      onTap: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkResponse(
                      child: Icon(
                        Icons.mode_comment_outlined,
                        size: 17,
                      ),
                      highlightColor: Colors.blue,
                      splashColor: Colors.blue,
                      onTap: () {
                        setState(() {
                          print('클릭');
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
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
                  color: Color(0xfffbeeb7),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width - 70,
                child: Expanded(
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 10, top: 10, bottom: 10),
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey),
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
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
