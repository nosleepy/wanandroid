// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';
import 'package:wanandroid/model/article_bean.dart';

ArticleModel articleModelFromJson(String str) => ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  ArticleModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  ArticleModelData data;
  int errorCode;
  String errorMsg;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    data: ArticleModelData.fromJson(json["data"]),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class ArticleModelData {
  ArticleModelData({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  int curPage;
  List<ArticleBean> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  factory ArticleModelData.fromJson(Map<String, dynamic> json) => ArticleModelData(
    curPage: json["curPage"],
    datas: List<ArticleBean>.from(json["datas"].map((x) => ArticleBean.fromJson(x))),
    offset: json["offset"],
    over: json["over"],
    pageCount: json["pageCount"],
    size: json["size"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "curPage": curPage,
    "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
    "offset": offset,
    "over": over,
    "pageCount": pageCount,
    "size": size,
    "total": total,
  };
}