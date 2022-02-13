import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Transaction 트랜잭션
//동시에 여러 유저가 like할 수 있으니까
class Like extends StatefulWidget {
  const Like(
      {Key key,
      @required this.reference,
      @required this.like,
      @required this.likedBy})
      : super(key: key);

  final DocumentReference reference;
  final int like;
  final likedBy;

  @override
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  //dart sdk version 2.15인데 null safety 적용 안되는ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ null safety 하고 싶다ㅏㅏㅏ
//null safety 안되니까 late도 사용할 수 없고, !도 사용할 수 없고, 여러모로 불편

  int _like;
  final auth = FirebaseAuth.instance;

  userID() {
    final user = auth.currentUser;
    if (user != null) {
      final user_id = user.uid;
      return user_id;
    }
  }

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
          int addLike =
              snapshot['like'] + 1; //snapshot.data()['like']는 왜 안되는 것인지..
          List likedBy_list = List.from(snapshot['likedBy']);
          likedBy_list.add(userID());
          transaction.update(
              widget.reference, {'like': addLike, 'likedBy': likedBy_list});
          //likedBy_list 사용하지 않고, arrayUnion 사용해서 uid 추가할 수 있음.

          //return 업데이트된 라이크와 이용쟈ID 추가한 리스트
          return () {
            addLike;
            likedBy_list;
          };
        })
        .then((value) => print("좋아요 $value로 Add됨."))
        .catchError((error) => print('좋아요 Add 오류: $error'));
  }

  Future<void> _removeLike() async {
    int currentLike = _like;
    setState(() {
      _like = currentLike - 1;
    });

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(widget.reference);

          if (!snapshot.exists) {
            throw Exception('데이터 존재하지 않음');
          }
          int removeLike = snapshot['like'] - 1;
          String uid = userID();
          transaction.update(widget.reference, {
            'like': removeLike,
            'likedBy': FieldValue.arrayRemove([uid])
          });

          //return 업데이트된 라이크와 이용쟈ID 추가한 리스트
          return () {
            removeLike;
            uid;
          };
        })
        .then((value) => print("좋아요 $value로 Remove 됨."))
        .catchError((error) => print('좋아요 Remove 오류: $error'));
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
        GestureDetector(
          child: Icon(
            widget.likedBy.contains(userID()) == true
                ? Icons.thumb_up_alt
                : Icons.thumb_up_alt_outlined,
            size: 17,
          ),
          onTap: widget.likedBy.contains(userID()) == false
              ? _addLike
              : _removeLike,
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
