import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(
    checked: true, createFactory: true, fieldRename: FieldRename.snake)
class CommentModel {
  final String userProfileUrl;
  final String userName;
  final String dateTime;
  final String comment;

  CommentModel({
    this.userProfileUrl,
    this.userName,
    this.dateTime,
    this.comment,
  });
}

List<CommentModel> commentData = [
  CommentModel(
      userName: '테스트',
      userProfileUrl: 'http://kaihuastudio.com/common/img/default_profile.png',
      dateTime: '1분 전',
      comment: 'Hello World!'),
  CommentModel(
      userName: '하이',
      userProfileUrl: 'http://kaihuastudio.com/common/img/default_profile.png',
      dateTime: '2분 전',
      comment: '안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕안녕')
];
