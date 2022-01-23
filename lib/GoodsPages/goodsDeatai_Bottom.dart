import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/model/goods.dart';

import './Comment.dart';
import '../model/comment_model.dart';

class Bottom extends StatefulWidget {
  final Goods goods;

  const Bottom({Key key, this.goods}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentIndex = 0;
  final bar = ['댓글', '리뷰', '먹TV'];

  @override
  void initState() {
    this._tabController = TabController(
        length: bar.length, initialIndex: currentIndex, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bar.length,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TabBar(
                isScrollable: true,
                labelColor: Color(0xfff1c40f),
                unselectedLabelColor: Colors.grey,
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicatorColor: Colors.transparent,
                controller: _tabController,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: bar.map((_bar) {
                  return Tab(
                    text: _bar,
                  );
                }).toList(),
                onTap: (int index) {
                  setState(() {
                    currentIndex = index;
                    _tabController.animateTo(index);
                  });
                },
              ),
            ),
          ),
          //IndexedStack will show a single child from a list of children based on index
          // while Visibility will maintain to show or hide view.
          IndexedStack(
            children: <Widget>[
              Visibility(
                child: Comment(goods: widget.goods,),
                maintainState: true, //invisible할 때도 child 유지
                visible: currentIndex == 0,
              ),
              Visibility(
                child: Review(),
                maintainState: true,
                visible: currentIndex == 1,
              ),
              Visibility(
                child: MukTV(),
                maintainState: true,
                visible: currentIndex == 2,
              ),
            ],
            index: currentIndex, //index는 The index of the child to show.
          )
        ],
      ),
    );
  }
}

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  String comment = '';
  final formKey =
      GlobalKey(); //폼 내부의 TextFormField 값을 저장하고, validation을 진행하는데 사용됨.
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addComment(value) {
    setState(() {
      commentData.add(value);
    });
  }

  Widget _buildcommentList() {
    return ListView.builder(itemBuilder: (context, index) {
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    padding: EdgeInsets.all(10),
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
                              onPressed: () async {},
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

class MukTV extends StatefulWidget {
  @override
  _MukTVState createState() => _MukTVState();
}

class _MukTVState extends State<MukTV> {
  @override
  Widget build(BuildContext context) {
    return Text('sdsd');
  }
}
