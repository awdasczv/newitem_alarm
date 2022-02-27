import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Delete extends StatefulWidget {
  Delete(@required this.reference, {Key key}) : super(key: key);

  final DocumentReference reference;

  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  final mainColor = Color(0xffFFC845);

  Future<void> _delete() async {
    return widget.reference.delete();
  }

  Future<void> Alert() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              '댓글 삭제',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text('댓글을 정말 삭제하시겠습니까?'),
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
                    Navigator.of(context).pop(2);
                    _delete();
                    final snackBar = SnackBar(
                      duration: const Duration(seconds: 1),
                      content: const Text('댓글이 삭제되었습니다'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      onTap: () {
        Navigator.pop(context);
        Alert();
      },
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
    );
  }
}
