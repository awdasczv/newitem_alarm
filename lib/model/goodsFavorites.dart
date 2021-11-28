import 'package:flutter/material.dart';

class goodsFavorites extends ChangeNotifier {
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
