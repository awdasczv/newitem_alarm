import 'package:json_annotation/json_annotation.dart';

var category = {
  0: '스낵',
  1: '빵집',
  2: '음료',
  3: '카페/디저트',
  4: '주류',
  5: '라면',
  6: '햄버거',
  7: '피자',
  8: '치킨',
  9: '즉석/냉동',
  10: '아이스크림',
  11: '과자'
};

@JsonSerializable(
    checked: true, createFactory: true, fieldRename: FieldRename.snake)
class Goods {
  String category;
  String brand;
  String brandlogo;
  String imageUrl1;
  String imageUrl2;
  String title;
  int price;
  double starScore;
  int review;
  String describe;
  String launchdate;
  int total_review_count;
  int photoreview_count;

  Goods({
    this.category,
    this.brand,
    this.brandlogo,
    this.imageUrl1,
    this.imageUrl2,
    this.title,
    this.price,
    this.starScore,
    this.review,
    this.describe,
    this.launchdate,
    this.total_review_count,
    this.photoreview_count,
  });
// factory Goods.fromJson(dynamic json) => _$GoodsFromJson(json); //후에 API만들고 직렬화할 것.
// Map toJson() => _$GoodsToJSon(this);
// Goods.fromJson(Map json) {
//   imageUrl = json['imageUrl'];
//   title = json['title'];
//   price = json['price'];
//   starScore = json['starScore'];
// }
// Map toJson() {
//   final Map goods_data = new Map();
//   goods_data['imageUrl'] = this.imageUrl;
//   goods_data['title'] = this.title;
//   goods_data['price'] = this.price;
//   goods_data['starScore'] = this.starScore;
//   return goods_data;
}

List<Goods> goodsList = [
  Goods(
      category: category[11],
      brand: '오리온',
      brandlogo:
          "https://blog.kakaocdn.net/dn/nsXAr/btq0g0l5ndp/9xoD9kQ9bpRSSdisnPk9K1/img.jpg",
      imageUrl1:
          "http://www.orionworld.com/Data/Goods/%EA%B3%A0%EB%9E%98%EB%B0%A5_%EC%B4%88%EC%BD%94%EB%B2%94%EB%B2%85_%EC%A0%9C%ED%92%88%EC%9D%B4%EB%AF%B8%EC%A7%80_228x220.jpg",
      imageUrl2:
          "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTcnFOFEo53dDGG_bee0KtG0NZZBO5G7eT7Ky1miuUnaLlMlRNk16OAI6hdflMAmhuShR7Pdlkwbdc&usqp=CAc",
      title: "고래밥 초코범벅",
      price: 1500,
      starScore: 4.3,
      review: 100,
      describe: """""딸기 그래놀라와 허니 그래놀라의 달콤한 만남! /n달콤한 미쯔블랙과 상큼한 딸기칼슘볼이 듬뿍!/n
  1. 국내생산 그래놀라 90%/n
  2. 상큼한 딸기 그래놀라와 달콤한 허니 그래놀라!/n
  3. 리얼 딸기와 상큼한 딸기칼슘볼이 듬뿍!/n
  4. 리얼딸기과즙과 비정제 사탕수수당을 넣어 깊은 풍미의 달콤함""",
      launchdate: '20210907',
      total_review_count: 11,
      photoreview_count: 5),
  Goods(
    category: category[11],
    brand: '오리온',
    brandlogo:
        "https://blog.kakaocdn.net/dn/nsXAr/btq0g0l5ndp/9xoD9kQ9bpRSSdisnPk9K1/img.jpg",
    imageUrl1:
        "http://www.orionworld.com/Data/Goods/%EC%98%A4!%EA%B7%B8%EB%9E%98%EB%86%80%EB%9D%BC%EB%94%B8%EA%B8%B0_3D-m[3].png",
    title: "오!그래놀라 딸기",
    price: 7000,
    starScore: 3.0,
    review: 4,
  ),
  Goods(
      category: category[11],
      brand: '오리온',
      brandlogo:
          "https://blog.kakaocdn.net/dn/nsXAr/btq0g0l5ndp/9xoD9kQ9bpRSSdisnPk9K1/img.jpg",
      imageUrl1:
          "http://www.orionworld.com/Data/Goods/%EC%8A%A4%EC%9C%99%EC%B9%A9%20%EA%B0%88%EB%A6%AD%EB%94%94%ED%95%91%EC%86%8C%EC%8A%A4%EB%A7%9B-m[2].png",
      title: "스윙칩 갈릭디핑소스맛",
      price: 2000,
      starScore: 3.9,
      review: 10)
];
