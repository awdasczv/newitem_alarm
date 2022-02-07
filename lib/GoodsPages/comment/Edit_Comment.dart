import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  const Edit(@required this.reference, {Key key}) : super(key: key);

  final DocumentReference reference;
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Navigator.pop(context);
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
