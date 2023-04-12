// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  List<BannerBean> data;
  int errorCode;
  String errorMsg;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    data: List<BannerBean>.from(json["data"].map((x) => BannerBean.fromJson(x))),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class BannerBean {
  BannerBean({
    required this.desc,
    required this.id,
    required this.imagePath,
    required this.isVisible,
    required this.order,
    required this.title,
    required this.type,
    required this.url,
  });

  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  factory BannerBean.fromJson(Map<String, dynamic> json) => BannerBean(
    desc: json["desc"],
    id: json["id"],
    imagePath: json["imagePath"],
    isVisible: json["isVisible"],
    order: json["order"],
    title: json["title"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "id": id,
    "imagePath": imagePath,
    "isVisible": isVisible,
    "order": order,
    "title": title,
    "type": type,
    "url": url,
  };
}