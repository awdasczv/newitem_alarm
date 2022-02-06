import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class commentListItem extends StatefulWidget {
  const commentListItem(
      @required this.userProfileUrl,
      @required this.userName,
      @required this.dateTime,
      @required this.text,
      @required this.userID,
      @required this.like,
      @required this.reference,
      {Key key})
      : super(key: key);

  final String userProfileUrl;
  final String userName;
  final dateTime;
  final String userID;
  final String text;
  final int like;
  final DocumentReference reference;

  @override
  _commentListItemState createState() => _commentListItemState();
}

class _commentListItemState extends State<commentListItem> {
  final auth = FirebaseAuth.instance;
  final mainColor = Color(0xfff1c40f);
  CollectionReference commentRef =
      FirebaseFirestore.instance.collection('comment');
  bool _isReply = false;
  bool _isClick = false;

  Future<void> updateComment(DocumentSnapshot doc, String text) {
    return commentRef.doc(doc.id).update({
      'text': text,
      'dateTime': Timestamp.now(),
    }).catchError((error) {
      return print('댓글 수정 오류: $error');
    });
  }

  Future<void> deleteComment(DocumentSnapshot doc) {
    return commentRef.doc(doc.id).delete().catchError((error) {
      return print('댓글 삭제 오류: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                                              const Icon(Icons.edit_outlined),
                                              const SizedBox(
                                                width: 17,
                                              ),
                                              const Text(
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
                                          Delete(widget.reference)
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
                    comment,
                    Row(
                      children: [
                        Like(reference: widget.reference, like: widget.like),
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
}

//Transaction 트랜잭션
//동시에 여러 유저가 like할 수 있으니까
class Like extends StatefulWidget {
  const Like({Key key, @required this.reference, @required this.like})
      : super(key: key);

  final DocumentReference reference;
  final int like;

  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  //dart sdk version 2.15인데 null safety 적용 안되는ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ null safety 하고 싶다ㅏㅏㅏ
//null safety 안되니까 late도 사용할 수 없고, !도 사용할 수 없고, 여러모로 불편

  int _like;

  //null safety만 되면 late 사용해서 굳이 initState() 핳 필요 없음.....
  @override
  void initState() {
    super.initState();
    _like = widget.like;
  }

  Future<void> _addLike() async {
    int currentLike = _like;
    setState(() {
      _like = currentLike + 1;
    });

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(widget.reference);

          if (!snapshot.exists) {
            throw Exception('데이터 존재하지 않음');
          }

          int updatedLike =
              snapshot['like'] + 1; //snapshot.data()['like']는 왜 안되는 것인지..
          transaction.update(widget.reference, {'like': updatedLike});

          return updatedLike;
        })
        .then((value) => print("좋아요 $value로 업데이트됨."))
        .catchError((error) => print('좋아요 업데이트 오류: $error'));
  }

  @override
  void didUpdateWidget(Like oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.like != oldWidget.like) {
      _like = widget.like;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: Icon(
            Icons.thumb_up_alt_outlined,
            size: 17,
          ),
          highlightColor: Colors.blue,
          onTap: _addLike,
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
    );
  }
}

class Update extends StatefulWidget {
  const Update(@required this.reference, @required this.text, {Key key})
      : super(key: key);

  final DocumentReference reference;
  final String text;

  @override
  Future<void> _update() async {
    return reference.update({'text': text});
  }

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Delete extends StatefulWidget {
  Delete(@required this.reference, {Key key}) : super(key: key);

  final DocumentReference reference;

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  final mainColor = Color(0xfff1c40f);

  @override
  Future<void> _delete() async {
    return widget.reference.delete();
  }

  @override
  Future<void> Alert() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('댓글을 정말 삭제하시겠습니까?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(1);
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
                    Navigator.of(context).pop(2);
                    _delete();
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
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
        child: Row(
          children: [
            const Icon(Icons.delete_outline),
            const SizedBox(
              width: 17,
            ),
            const Text(
              '삭제',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ],
        ),
        onTap: Alert);
  }
}
