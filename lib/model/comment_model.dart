import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(
    checked: true, createFactory: true, fieldRename: FieldRename.snake)
class CommentModel {
  final String userProfileUrl;
  final String userName;
  var dateTime;
  final String text;
  final String userID;
  final int like;

  CommentModel({
    this.userProfileUrl,
    this.userName,
    this.dateTime,
    this.text,
    this.userID,
    this.like,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        userProfileUrl: json['userProfileUrl'] as String,
        userName: json['userName'] as String,
        dateTime: json['dateTime'],
        text: json['text'] as String,
        userID: json['userID'] as String,
        like: json['like'] as int);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userProfileUrl': userProfileUrl,
      'userName': userName,
      'dateTime': dateTime,
      'text': text,
      'like': like,
    };
  }
}
