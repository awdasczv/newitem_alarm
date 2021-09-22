import 'package:flutter/material.dart';
import 'package:newitem_alarm/HomePages/HomePage.dart';
import 'package:newitem_alarm/LikePages/LikeHome.dart';
import 'package:newitem_alarm/ProfilePages/ProfileHome.dart';
import 'package:newitem_alarm/WatchPages/WatchHome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TestProvider())],
      child: MaterialApp(
        title: '먹어봤니',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: '먹어봤니'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _bottomNavigatorBarList = [
    HomePage(),
    LikeHome(),
    WatchHome(),
    ProfileHome()
  ];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _bottomNavigatorBarList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '찜목록'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: '워치'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필')
        ],
      ),
    );
  }
}
