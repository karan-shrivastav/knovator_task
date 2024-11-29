// To parse this JSON data, do
//
//     final postIdModel = postIdModelFromJson(jsonString);

import 'dart:convert';

PostIdModel postIdModelFromJson(String str) => PostIdModel.fromJson(json.decode(str));

String postIdModelToJson(PostIdModel data) => json.encode(data.toJson());

class PostIdModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  PostIdModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostIdModel.fromJson(Map<String, dynamic> json) => PostIdModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
