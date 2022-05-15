import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './Delete_Comment.dart';
import './Edit_Comment.dart';
import './Like.dart';

class commentListItem extends StatefulWidget {
  const commentListItem(
      @required this.userProfileUrl,
      @required this.userName,
      @required this.dateTime,
      @required this.text,
      @required this.userID,
      @required this.like,
      @required this.likedBy,
      @required this.reference,
      {Key key})
      : super(key: key);

  final String userProfileUrl;
  final String userName;
  final dateTime;
  final String userID;
  final String text;
  final int like;
  final likedBy;
  final DocumentReference reference;


  @override
  _commentListItemState createState() => _commentListItemState();
}

class _commentListItemState extends State<commentListItem> {
  final auth = FirebaseAuth.instance;
  final mainColor = Color(0xffFFC845);
  bool isReply = false;

  // Future<void> updateComment(DocumentSnapshot doc, String text) {
  //   return commentRef.doc(doc.id).update({
  //     'text': text,
  //     'dateTime': Timestamp.now(),
  //   }).catchError((error) {
  //     return print('댓글 수정 오류: $error');
  //   });
  // }

  // Future<void> deleteComment(DocumentSnapshot doc) {
  //   return commentRef.doc(doc.id).delete().catchError((error) {
  //     return print('댓글 삭제 오류: $error');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isReply ? mainColor.withOpacity(.09) : null,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userProfile,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          metadata,
                          Spacer(),
                          InkResponse(
                            child: Icon(
                              Icons.more_vert_sharp,
                              size: 20,
                            ),
                            onTap: () {
                              _showBottomSheet();
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      comment,
                      Row(
                        children: [
                          Like(
                            reference: widget.reference,
                            like: widget.like,
                            likedBy: widget.likedBy,
                          ),
                          InkResponse(
                            child: const Icon(
                              Icons.mode_comment_outlined,
                              size: 17,
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        '답글 작성',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text('답글을 작성하시겠습니까?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              '취소',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              isReply = !isReply;
                                            },
                                            child: Text(
                                              '확인',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    );
                                  });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.4,
            height: 0,
          )
        ],
      ),
    );
  }

  Widget get comment {
    return Container(
        padding: EdgeInsets.only(top: 5, bottom: 15),
        width: MediaQuery.of(context).size.width * .8,
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 15),
        ));
  }

  Widget get userProfile {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CircleAvatar(
        backgroundImage: widget.userProfileUrl == null
            ? AssetImage('assets/images/default_profile.png')
            : NetworkImage(widget.userProfileUrl),
        radius: 15,
      ),
    );
  }

  Widget get metadata {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            widget.userName == null ? '비회원' : widget.userName,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          Text(' · '),
          Text(
            DateFormat('MM/dd HH:mm')
                .format(widget.dateTime.toDate())
                .toString(),
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Future<void> _showBottomSheet() {
    return showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        isScrollControlled: false,
        elevation: 5,
        context: context,
        builder: (context) {
          return Container(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Edit(widget.reference),
                  const SizedBox(
                    height: 20,
                  ),
                  Delete(
                    widget.reference,
                  )
                ],
              ),
            ),
          );
        });
  }
}
