// To parse this JSON data, do
//
//     final topArticleModel = topArticleModelFromJson(jsonString);

import 'dart:convert';
import 'package:wanandroid/model/article_bean.dart';

TopArticleModel topArticleModelFromJson(String str) => TopArticleModel.fromJson(json.decode(str));

String topArticleModelToJson(TopArticleModel data) => json.encode(data.toJson());

class TopArticleModel {
  TopArticleModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  List<ArticleBean> data;
  int errorCode;
  String errorMsg;

  factory TopArticleModel.fromJson(Map<String, dynamic> json) => TopArticleModel(
    data: List<ArticleBean>.from(json["data"].map((x) => ArticleBean.fromJson(x))),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}