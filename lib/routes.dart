import 'package:flutter/material.dart';
import 'package:newitem_alarm/SplashScreen.dart';
import 'package:newitem_alarm/WatchPages/WatchHome.dart';
import 'package:newitem_alarm/main.dart';

import './LikePages/LikeHome.dart';
import 'HomePages/HomePage.dart';

final Map<String, WidgetBuilder> route = {
  HomePage.routeName: (context) => HomePage(),
  LikeHome.routeName: (context) => LikeHome(),
  MyApp.routeName: (context) => MyApp(),
  WatchHome.routeName: (context) => WatchHome(),
  //SignInScreen.routeName: (context) => SignInScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
};
