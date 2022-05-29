import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './Comment.dart';

class Edit extends StatefulWidget {
  const Edit(@required this.reference, @required this.comment, {Key key})
      : super(key: key);

  final DocumentReference reference;
  final Comment comment;

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final mainColor = Color(0xffFFC845);
  final auth = FirebaseAuth.instance;

  void _edit(String commentID, String text) async {
    widget.comment.editingController.clear();
    FocusScope.of(context).unfocus();
    widget.reference.update({'text': text});
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Navigator.pop(context);
        var userID = widget.reference.get().then((value) => value['userID']);
        if (auth.currentUser.uid == userID) {
          _edit(widget.reference.id, widget.comment.editingController.text);
        }
        ;
      },
      child: Row(
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
    );
  }
}
