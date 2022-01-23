import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(
    checked: true, createFactory: true, fieldRename: FieldRename.snake)
class Category {
  final String category_title;
  final String category_icon;

  Category({
    this.category_title,
    this.category_icon,
  });
}

//category_icon 이미지 추가해야 함.
List<Category> categories = [
  Category(
    category_title: '전체',
  ),
  Category(
    category_title: '스낵',
  ),
  Category(
    category_title: '빵집',
  ),
  Category(
    category_title: '음료',
  ),
  Category(
    category_title: '카페/디저트',
  ),
  Category(
    category_title: '주류',
  ),
  Category(
    category_title: '라면',
  ),
  Category(
    category_title: '햄버거',
  ),
  Category(
    category_title: '피자',
  ),
  Category(
    category_title: '치킨',
  ),
  Category(
    category_title: '즉석/냉동',
  ),
  Category(
    category_title: '아이스크림',
  ),
  Category(
    category_title: '과자',
  ),
];
