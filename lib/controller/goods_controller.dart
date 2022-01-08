import 'package:get/get.dart';

import '../model/goods.dart';

//GetX state mangement 유용하게 해줌 => DisposableInterface  extend한 추상클래스
//DisposableInteface(dispose of controller from memory => 메모리 줄이고, 애플리케이션 성능 향상)
class goodsController extends GetxController {
  List<Goods> get goods {
    return [...goodsList];
  }

  //goods id를 인수로 받아서 특정 id의 goods 반환.
  Goods find_goodsId(int id) {
    //firstWhere  element 반복하고, 주어진 조건의 첫번째 element 반환
    return goodsList.firstWhere((goods) => goods.id == id);
  }

  Goods find_goodsCategory(String category) {
    return goodsList.firstWhere((goods) => goods.category == category);
  }

  //isFavorite true인 goods 리스트
  List<Goods> get favoriteGoods {
    //where element(여기서는 goods로 표시) 필터링
    return goodsList.where((goods) => goods.isFavorite).toList();
  }

  //특정 id의 goods를  isFavorite update함함
  void isFavoriteStatus(int id) {
    goodsList[id].isFavorite = !goodsList[id].isFavorite;
    update(); //Provider 패키지에서는 update와 비슷한 걸로, notifyListeners가 있음.
  }
}
