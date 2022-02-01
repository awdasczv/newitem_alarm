import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class commentListItem extends StatefulWidget {
  const commentListItem(
      this.userProfileUrl, this.userName, this.dateTime, this.text, this.userID,
      {Key key})
      : super(key: key);

  final String userProfileUrl;
  final String userName;
  final dateTime;
  final String userID;
  final String text;

  @override
  _commentListItemState createState() => _commentListItemState();
}

class _commentListItemState extends State<commentListItem> {
  int _like = 0; //위치 중요!!....
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(
              backgroundImage: widget.userProfileUrl == null
                  ? AssetImage('assets/images/default_profile.png')
                  : NetworkImage(widget.userProfileUrl),
              radius: 15,
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
                ),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width * .8,
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 15),
                    )),
                Row(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 17,
                          ),
                          highlightColor: Colors.blue,
                          onTap: () {
                            setState(() {
                              _like += 1;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        SizedBox(
                          width: 60,
                          child: _like == 0
                              ? Text('')
                              : Text(
                                  _like.toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                        )
                      ],
                    ),
                    InkResponse(
                      child: Icon(
                        Icons.mode_comment_outlined,
                        size: 17,
                      ),
                      highlightColor: Colors.blue,
                      splashColor: Colors.blue,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
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
                                            color: Color(0xfff1c40f),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        '확인',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xfff1c40f),
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              );
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
}
