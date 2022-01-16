import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<String> searchHistory = [];
  Future<List<String>> _sh;
  final TextEditingController _tc = TextEditingController();

  FocusNode _focusNode = FocusNode();   // 검색창에 커서가 있는지에 대한 상태

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sh = _readSearchHistory();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 3, 10, 0),
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _tc,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (String _str){
                          searchButton();
                        },
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          labelText: '검색',
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end, // added line
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _focusNode.hasFocus ? IconButton(
                                icon: Icon(Icons.cancel, color: Colors.grey, size: 20,),
                                onPressed: () {
                                  setState(() {
                                    _tc.clear();
                                  });
                                },
                              ):Container(),
                              IconButton(
                                icon : Icon(Icons.search,size: 30),
                                color: Colors.black,
                                onPressed: (){searchButton();},
                              ),
                            ],
                          ),
                          focusedBorder: _outlineInputBorder(),
                          enabledBorder: _outlineInputBorder(),
                          border: _outlineInputBorder(),
                        ),

                      ),
                    )
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text('최근검색어',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            ),
           Container(
             padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
             height: 50,
             child: FutureBuilder(
               future: _sh,
               builder: (context, snapshot){
                 if(snapshot.hasData){
                   if(snapshot.data.length > 0){
                     searchHistory = snapshot.data as List<String>;
                     return ListView.separated(
                       shrinkWrap: true,
                       itemCount: snapshot.data.length,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (BuildContext context, int index){
                         return _chip(index);
                       },
                       separatorBuilder: (BuildContext context, int index){
                         return SizedBox(width: 10,);
                       },
                     );
                   }
                   else{
                     return Text('검색 기록이 없습니다.');
                   }
                 }
                 else if (snapshot.hasError){return Text("Error : Error at reading Search History ");}
                 return CircularProgressIndicator();
               },
             )
           ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text('추천검색어',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
            ),
           Padding(
             padding:  EdgeInsets.fromLTRB(10, 5, 10, 10),
             child:  Wrap(
               spacing: 6.0,
               runSpacing: 6.0,
               children: [
                 Chip(label: Text('추천검색어1'),backgroundColor: Color(0xfff1c40f),),
                 Chip(label: Text('짧은거'),backgroundColor: Color(0xfff1c40f),),
                 Chip(label: Text('짧'),backgroundColor: Color(0xfff1c40f),),
                 Chip(label: Text('기이이인검색어1'),backgroundColor: Color(0xfff1c40f),),
                 Chip(label: Text('디따기이이이이이이이인 검색어'),backgroundColor: Color(0xfff1c40f),),
                 Chip(label: Text('배고프다'),backgroundColor: Color(0xfff1c40f),),
               ],
             ),
           )
          ],
        ),
      )
    );
  }

  void searchButton() async{
    searchHistory.add(_tc.text.toString());
    await _writeSearchHistory(searchHistory);

    setState(() {
      _sh =  _readSearchHistory();
    });
  }

  Chip _chip(int index){
     return Chip(
       label: Text(searchHistory[index]),
       deleteIcon: Icon(Icons.clear,size: 20,),
       backgroundColor: Color(0xfff1c40f),
       onDeleted: () async{

         setState(() {
           searchHistory.removeAt(index);
         });
         await _writeSearchHistory(searchHistory);
       },
     );
  }

  OutlineInputBorder _outlineInputBorder(){
     return  OutlineInputBorder(
         borderSide: BorderSide(color: Colors.black),
         borderRadius: BorderRadius.all(Radius.circular(10))
     );
  }

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<List<String>> _readSearchHistory()async{
    List<String> _res = [];

    try{
      final _path = await _localPath;
      final _file = File('$_path.searchHistory.txt');

      String _str = await _file.readAsString(encoding: utf8);

      _res = _str.split('\n');

      _res.remove('');

      return _res;
    }
    catch(e){
      return [];
    }
  }

  Future<void> _writeSearchHistory(List<String> searchHistory) async{

    final _path = await _localPath;
    final _file = File('$_path.searchHistory.txt');

    String _buff = "";

    if(searchHistory.length < 1){
      _file.writeAsString('');
      return;
    }

    for(int i = 0 ; i < searchHistory.length - 1 ; i++){
      _buff = _buff + searchHistory[i] + "\n";
    }
    _buff = _buff + searchHistory.last;

    await _file.writeAsString(_buff);
  }

  Container _doyoonBody(){

    return Container(
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
                        focusNode: _focusNode,
                        style: TextStyle(fontSize: 15),
                        autofocus: true,
                        controller: _tc,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white12,
                          prefixIcon: Icon(Icons.search, color: Colors.black, size: 20),
                          suffixIcon: _focusNode.hasFocus
                              ? IconButton(
                            icon: Icon(
                              Icons.cancel, color: Colors.grey, size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _tc.clear();

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
                    _focusNode.hasFocus
                        ? Expanded(
                      child: GestureDetector(
                        child: Center(child: Text('취소', style: TextStyle(fontSize: 15, color: Colors.black),),),
                        onTap: () {
                          setState(() {
                            _tc.clear();
                            _focusNode.unfocus();
                          });
                        },
                      ),
                    ) : Expanded(flex: 0, child: Container(),)
                  ],
                )
            ),
          ],
        )
    );
  }
}
