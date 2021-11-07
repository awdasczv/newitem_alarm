import 'package:flutter/material.dart';

import './LikePages/GoodsPages/goodsDetail.dart';
import 'HomePages/HomePage.dart';

final Map<String, WidgetBuilder> route = {
  HomePage.routeName: (context) => HomePage(),
  DetailMain.routeName: (context) => DetailMain()
};
