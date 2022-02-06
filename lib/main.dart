import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newitem_alarm/GoodsPages/comment/Comment_Provider.dart';
import 'package:newitem_alarm/HomePages/HomePage.dart';
import 'package:newitem_alarm/LikePages/LikeHome.dart';
import 'package:newitem_alarm/ProfilePages/ProfileHome.dart';
import 'package:newitem_alarm/SplashScreen.dart';
import 'package:newitem_alarm/WatchPages/WatchHome.dart';
import 'package:newitem_alarm/routes.dart';
import 'package:provider/provider.dart';

import 'GoodsPages/comment/Comment_Provider.dart';
import 'model/comment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //파이어베이스 사용할 때 해당 두 줄은 꼭 추가하기
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static String routeName = "/MyApp";
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TestProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider(CommentModel))
      ],
      child: MaterialApp(
        title: '먹어봤니',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splash: SplashScreen(),
          nextScreen: MyHomePage(),
          splashTransition: SplashTransition.fadeTransition,
        ),
        debugShowCheckedModeBanner: false,
        routes: route,
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
        iconSize: 28,
        unselectedItemColor: Colors.black38,
        fixedColor: Color(0xfff1c40f),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '찜'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: '먹TV'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필')
        ],
      ),
    );
  }
}
