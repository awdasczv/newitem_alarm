import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List searchKeyword = ["불고기", "닭갈비", "삼겹살", "갈비곰탕", "생새우살"];
  final TextEditingController _filter = TextEditingController();

  FocusNode focusNode = FocusNode();   // 검색창에 커서가 있는지에 대한 상태
  String _searchText = "";

  // 검색 위젯을 컨트롤하는 _filter가 변화를 감지하여 _searchText의 상태를 변화시킨다.
  _SearchPageState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30),
              ),
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 6,
                          child: TextField(
                              focusNode: focusNode,
                              style: TextStyle(fontSize: 15),
                              autofocus: true,
                              controller: _filter,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white12,
                                prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
                                suffixIcon: focusNode.hasFocus
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.cancel, color: Colors.grey, size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _filter.clear();
                                            _searchText = "";
                                          });
                                        },
                                      )
                                    : Container(),   // 커서가 있을 때 cancel 버튼을 띄우고, 아니라면 빈 상태로 보여준다.
                                hintText: '검색',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ), // foucusBorder 투명하게 설정
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                              ),
                          ),
                      ),
                      focusNode.hasFocus
                          ? Expanded(
                        child: GestureDetector(
                          child: Center(child: Text('취소', style: TextStyle(fontSize: 15, color: Colors.black),),),
                          onTap: () {
                            setState(() {
                              _filter.clear();
                              _searchText = "";
                              focusNode.unfocus();
                            });
                          },
                        ),
                      ) : Expanded(flex: 0, child: Container(),)
                    ],
                  )
              ),
              /*Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    // 2
                    //DefaultSearchField(),
                    const SizedBox(height: 20),
                    Text("인기 검색어", style: TextStyle(color: Colors.blue)),
                    // 3
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: 400,
                      child: ListView.separated(
                        itemBuilder: (context, index) => Container(
                          child: SizedBox(
                            height: 50,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                searchKeyword[index],
                                style: TextStyle(color: Colors.blue, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => Divider(
                          thickness: 0.5,
                          height: 0,
                        ),
                        itemCount: searchKeyword.length,
                      ),
                    )
                  ],
                ),
              ),*/
            ],
          )
      )
    );
  }


}
