import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(
    checked: true, createFactory: true, fieldRename: FieldRename.snake)
class CommentModel {
  final String userProfileUrl;
  final String userName;
  var dateTime;
  final String text;

  CommentModel({
    this.userProfileUrl,
    this.userName,
    this.dateTime,
    this.text,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userProfileUrl: json['userProfileUrl'] as String,
      userName: json['userName'] as String,
      dateTime: json['dateTime'],
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userProfileUrl': userProfileUrl,
      'userName': userName,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
