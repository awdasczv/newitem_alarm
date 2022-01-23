import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Comment_Provider.dart';
import '../model/comment_model.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String comment = '';
  final formKey =
      GlobalKey(); //폼 내부의 TextFormField 값을 저장하고, validation을 진행하는데 사용됨.
  TextEditingController _textEditingController = TextEditingController();
  StreamSubscription _streamSubscription;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    final p = Provider.of<CommentProvider>(context, listen: false);
    Future.microtask(() => p.load());
    _streamSubscription = p.getSnapshot().listen((event) {
      p.addComment(CommentModel.fromJson(event.docs[0].data()));
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  Widget _buildcommentList() {
    final p = Provider.of<CommentProvider>(context);
    return ListView.builder(
        reverse: true,
        itemBuilder: (context, index) {
          if (index < commentData.length) {
            return _buildcommentItem(commentmodel: commentData[index]);
          }
        });
  }

  Widget _buildcommentItem({@required CommentModel commentmodel}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(commentmodel.userProfileUrl),
              radius: 20,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * .75,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      commentmodel.comment,
                      style: TextStyle(fontSize: 15),
                    )),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        commentmodel.dateTime,
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('좋아요')
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.mode_comment_outlined,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text('답글')
                        ],
                      )
                    ],
                  ),
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
    final p = Provider.of<CommentProvider>(context);
    return SafeArea(
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(child: _buildcommentList()),
              Spacer(),
              SafeArea(
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height *
                          .5), //고정값을 줄 수 있음
                  width: MediaQuery.of(context).size.width,
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
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xfffbeeb7),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: MediaQuery.of(context).size.width - 70,
                            child: Form(
                              key: this.formKey,
                              child: TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                controller: _textEditingController,
                                focusNode: _focusNode,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, right: 10, top: 10, bottom: 10),
                                  hintText: '  댓글을 적어주세요.',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  alignLabelWithHint: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    comment = value;
                                  });
                                },
                              ),
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                            backgroundColor: Color(0xfff1c40f),
                            radius: 20,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_rounded,
                                size: 25,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                String text = _textEditingController.text;
                                _textEditingController.text = '';
                                p.send(text);
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
