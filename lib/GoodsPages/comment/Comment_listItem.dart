import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  final mainColor = Color(0xfff1c40f);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                widget.userName == null
                                    ? '비회원'
                                    : widget.userName,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700]),
                              ),
                              Text(' · '),
                              Text(
                                DateFormat('MM/dd HH:mm')
                                    .format(widget.dateTime.toDate())
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        InkResponse(
                          child: Icon(
                            Icons.more_vert_sharp,
                            size: 20,
                          ),
                          onTap: () {
                            showModalBottomSheet<void>(
                                backgroundColor: Colors.white,
                                isScrollControlled: false,
                                elevation: 5,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 90,
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.edit_outlined),
                                              const SizedBox(
                                                width: 17,
                                              ),
                                              Text(
                                                '수정',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.delete_outline),
                                              const SizedBox(
                                                width: 17,
                                              ),
                                              Text(
                                                '삭제',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 15),
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
                                                color: mainColor,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      TextButton(
                                          onPressed: () {},
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
        )
      ],
    );
  }
}
