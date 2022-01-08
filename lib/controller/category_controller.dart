import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../LikePages/Like_Goods_Body.dart';
import '../model/category.dart';
import '../model/goods.dart';

class categoryController extends GetxController {
  List<Goods> allgoodsList = [];
  List<Goods> snackList = [];
  List<Goods> breadList = [];
  List<Goods> drinkList = [];
  List<Goods> cafeList = [];
  List<Goods> alcholList = [];
  List<Goods> ramenList = [];
  List<Goods> hamburgerList = [];
  List<Goods> pizzaList = [];
  List<Goods> chickenList = [];
  List<Goods> instantList = [];
  List<Goods> icecreamList = [];
  List<Goods> cookieList = [];

  List<Category> get categories => categories;
  TabController tabController;
  int current_category_index;
  String current_category_title;

  @override
  void onInit() {
    super
        .onInit(); //When controller is created in memory, onInit() method is called immediately
  }

  @override
  void onClose() {
    super
        .onReady(); //When controller is removed in memory, onClos() method is called
  }

  @override
  void onReady() {
    super.onClose(); //위젯이 스크린에 출력될 때, onReady() method is called
  }

  void addGooods(Goods goods) {
    allgoodsList.add(goods); //0은 '전체'
    switch (goods.category) {
      case '스낵':
        snackList.add(goods);
        tabController.animateTo(1);
        break;
      case '빵집':
        snackList.add(goods);
        tabController.animateTo(2);
        break;
      case '음료':
        snackList.add(goods);
        tabController.animateTo(3);
        break;
      case '카페/디저트':
        snackList.add(goods);
        tabController.animateTo(4);
        break;
      case '주류':
        snackList.add(goods);
        tabController.animateTo(5);
        break;
      case '라면':
        snackList.add(goods);
        tabController.animateTo(6);
        break;
      case '햄버거':
        snackList.add(goods);
        tabController.animateTo(7);
        break;
      case '피자':
        snackList.add(goods);
        tabController.animateTo(8);
        break;
      case '치킨':
        snackList.add(goods);
        tabController.animateTo(9);
        break;
      case '즉석/냉동':
        snackList.add(goods);
        tabController.animateTo(10);
        break;
      case '아이스크림':
        snackList.add(goods);
        tabController.animateTo(11);
        break;
      case '과자':
        snackList.add(goods);
        tabController.animateTo(12);
        break;
    }
    update();
  }

  void selectedCategory(int index) {
    current_category_index = index;
    current_category_title = category[index];
    Get.to(() => Like_Goods_Body());
    update();
  }
}
