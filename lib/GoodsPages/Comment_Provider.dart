import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/comment_model.dart';

class CommentProvider extends ChangeNotifier {
  CommentProvider(@required CommentModel);

  var commentData = <CommentModel>[];

  void addComment(CommentModel model) {
    commentData.insert(0, model);
    notifyListeners();
  }

  Stream<QuerySnapshot> getSnapshot() {
    final f = FirebaseFirestore.instance;
    return f
        .collection('comment')
        .limit(1)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  Future<List<CommentModel>> load() async {
    var now = DateTime.now().microsecondsSinceEpoch.toString();
    final f = FirebaseFirestore.instance;
    var output = await f
        .collection('comment')
        .where('datetime', isGreaterThan: now)
        .orderBy('dateTime', descending: true)
        .get();
    var iterable =
        output.docs.map((e) => CommentModel.fromJson(e.data())).toList();
    commentData.addAll(iterable);
    notifyListeners();
  }

  Future<List<CommentModel>> send(String text) async {
    var now = DateTime.now().microsecondsSinceEpoch.toString();
    final f = FirebaseFirestore.instance;
    await f.collection('comment').doc(now).set(CommentModel().toJson());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('comment')
            .limit(1)
            .orderBy('dateTime', descending: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final commentDocs = snapshot.data.docs;
          return ListView.builder(
              itemCount: commentDocs.length,
              itemBuilder: (context, index) {
                return Text(commentDocs[index]['text']);
              });
        });
  }
}
