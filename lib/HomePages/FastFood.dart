import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/GoodsPages/goodsDetail_New.dart';
import 'package:newitem_alarm/HomePages/Calendar_timeline.dart';
import 'package:newitem_alarm/model/Firestore_model.dart';
import 'package:newitem_alarm/model/goods.dart';

import './Calendar_timeline.dart';
import '../LikePages/Category.dart';
import '../LikePages/Goods_Card.dart';
import '../model/goods.dart';

class FastFood extends StatefulWidget {
  final String changeName;

  const FastFood({Key key, this.changeName}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<FastFood> {
  DateTime _selectedDateTime = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  String text = '';

  Map categorize = {
    '젤리/초콜릿': 1,
    '빵': 2,
    '음료': 3,
    '카페/디저트': 4,
    '주류': 5,
    '라면': 6,
    '햄버거': 7,
    '피자': 8,
    '치킨': 9,
    '즉석/냉동': 10,
    '아이스크림': 11,
    '과자': 12
  };

  List yearList = ["2021년", "2020년", "2019년"];

  List monthList = [
    "12월",
    "11월",
    "10월",
    "09월",
    "08월",
    "07월",
    "06월",
    "05월",
    "04월",
    "03월",
    "02월",
    "01월"
  ];

  final _colorList1 = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.red,
    Colors.amber,
    Colors.brown,
    Colors.yellow,
  ];
  final _colorList2 = [Colors.teal, Colors.black87];

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  String year;
  String month;

  String pn;

  @override
  void initState() {
    super.initState();
    pn = widget.changeName;

    year = DateTime.now().year.toString();
    month = DateTime.now().month.toString();
  }

  Widget calendar() {
    if (_selectedDate == null) {
      return Text("");
    } else {
      return Text(
        '$_selectedDateTime',
        style: TextStyle(fontSize: 20),
      );
    }
  }

  /*Widget ChangeProductName() {
    if(pn[0])
      {
        return Text(
          "젤리/초콜릿",
          style: TextStyle(fontSize: 25, color: Colors.black),
        );
      }
    if(pn[0])
    {
      return Text(
        "빵",
        style: TextStyle(fontSize: 25, color: Colors.black),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            // 한 화면에 여러 개의 스크롤 사용 가능
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  expandedHeight: 170,
                  bottom: PreferredSize(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Calendar(),
                    ),
                    preferredSize: Size.fromHeight(110),
                  ),
                  centerTitle: true,
                  title: Text(
                    pn,
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  floating: true,
                  snap: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.black,
                      size: 23,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container();
                    },
                    childCount: 20,
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                Card(
                  child: Category(),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child:_futureGridView()
                    )
                )
              ],
            )
        )
    );
  }

  Widget _futureGridView(){
    CollectionReference goodsRef = FirebaseFirestore.instance.collection('Goods');
    return FutureBuilder<QuerySnapshot>(
        future: goodsRef.orderBy('launchdate',descending: false).get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xfff1c40f))),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final List<QueryDocumentSnapshot<Object>> _newGoodsList = snapshot.data.docs;

          List<NewGoods> categorizeGoods = [];
          for(int i = 0; i < _newGoodsList.length - 1; i++)
          {
            NewGoods allGoods = NewGoods.fromJson(_newGoodsList[i].data());
            if(allGoods.category == categorize["전체"])
            {
              categorizeGoods.add(NewGoods.fromJson(_newGoodsList[i].data()));
            }
            else if(allGoods.category == categorize[widget.changeName])
            {
              categorizeGoods.add(allGoods);
            }
          }

          return GridView.builder(
              shrinkWrap: true,
              itemCount: categorizeGoods.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  //2행
                  childAspectRatio: 0.65,
                  //mainAxis에 대한 교차축 비율
                  mainAxisSpacing: 10,
                  //mainAxis를 따라 각 child 사이 크기 //위로 얼마나 띄어져 있는지
                  crossAxisSpacing: 10 //같은 행에 있는 child 간 사이 크기
              ),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoodsDetailHome(
                              goods: categorizeGoods[index],
                            )
                        )
                    );
                  },
                  child: GoodsCard(
                    goods: categorizeGoods[index],
                  )
              )
          );
        }
    );
  }

  /*
  Widget _previousGridView(){
    return  GridView.builder(
        shrinkWrap: true, //필요한 공간만 차지
        itemCount: goodsList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            //2행
            childAspectRatio: 0.65,
            //mainAxis에 대한 교차축 비율
            mainAxisSpacing: 10,
            //mainAxis를 따라 각 child 사이 크기 //위로 얼마나 띄어져 있는지
            crossAxisSpacing: 10 //같은 행에 있는 child 간 사이 크기
        ),
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoodsDetailHome(
                        goods: goodsList[index],
                      )
                  )
              );
            },
            child: GoodsCard(
              goods: goodsList[index],
            )
        )
    ),
  }
*/
}
