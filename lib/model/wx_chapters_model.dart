// To parse this JSON data, do
//
//     final wxChaptersModel = wxChaptersModelFromJson(jsonString);

import 'dart:convert';

WxChaptersModel wxChaptersModelFromJson(String str) => WxChaptersModel.fromJson(json.decode(str));

String wxChaptersModelToJson(WxChaptersModel data) => json.encode(data.toJson());

class WxChaptersModel {
  WxChaptersModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  List<WxChaptersBean> data;
  int errorCode;
  String errorMsg;

  factory WxChaptersModel.fromJson(Map<String, dynamic> json) => WxChaptersModel(
    data: List<WxChaptersBean>.from(json["data"].map((x) => WxChaptersBean.fromJson(x))),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class WxChaptersBean {
  WxChaptersBean({
    required this.articleList,
    required this.author,
    required this.children,
    required this.courseId,
    required this.cover,
    required this.desc,
    required this.id,
    required this.lisense,
    required this.lisenseLink,
    required this.name,
    required this.order,
    required this.parentChapterId,
    required this.type,
    required this.userControlSetTop,
    required this.visible,
  });

  List<dynamic> articleList;
  String author;
  List<dynamic> children;
  int courseId;
  String cover;
  String desc;
  int id;
  String lisense;
  String lisenseLink;
  String name;
  int order;
  int parentChapterId;
  int type;
  bool userControlSetTop;
  int visible;

  factory WxChaptersBean.fromJson(Map<String, dynamic> json) => WxChaptersBean(
    articleList: List<dynamic>.from(json["articleList"].map((x) => x)),
    author: json["author"],
    children: List<dynamic>.from(json["children"].map((x) => x)),
    courseId: json["courseId"],
    cover: json["cover"],
    desc: json["desc"],
    id: json["id"],
    lisense: json["lisense"],
    lisenseLink: json["lisenseLink"],
    name: json["name"],
    order: json["order"],
    parentChapterId: json["parentChapterId"],
    type: json["type"],
    userControlSetTop: json["userControlSetTop"],
    visible: json["visible"],
  );

  Map<String, dynamic> toJson() => {
    "articleList": List<dynamic>.from(articleList.map((x) => x)),
    "author": author,
    "children": List<dynamic>.from(children.map((x) => x)),
    "courseId": courseId,
    "cover": cover,
    "desc": desc,
    "id": id,
    "lisense": lisense,
    "lisenseLink": lisenseLink,
    "name": name,
    "order": order,
    "parentChapterId": parentChapterId,
    "type": type,
    "userControlSetTop": userControlSetTop,
    "visible": visible,
  };
}