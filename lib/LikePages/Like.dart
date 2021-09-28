import 'package:flutter/material.dart';

/// 유저가 Like누르면 연결되도록 하려고 함. 후에 할 일.
/// setSate()를 이용할 수도 있을 것 같음.
class ClickLike extends ChangeNotifier {
  final List<int> _favoritegoods = [];

  List<int> get goods => _favoritegoods;

  void add(int goodsNo) {
    _favoritegoods.add(goodsNo);
    notifyListeners();
  }

  void remove(int goodsNo) {
    _favoritegoods.remove(goodsNo);
    notifyListeners();
  }
}
