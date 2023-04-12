// To parse this JSON data, do
//
//     final projectTreeModel = projectTreeModelFromJson(jsonString);

import 'dart:convert';

ProjectTreeModel projectTreeModelFromJson(String str) => ProjectTreeModel.fromJson(json.decode(str));

String projectTreeModelToJson(ProjectTreeModel data) => json.encode(data.toJson());

class ProjectTreeModel {
  ProjectTreeModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  List<ProjectTreeBean> data;
  int errorCode;
  String errorMsg;

  factory ProjectTreeModel.fromJson(Map<String, dynamic> json) => ProjectTreeModel(
    data: List<ProjectTreeBean>.from(json["data"].map((x) => ProjectTreeBean.fromJson(x))),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class ProjectTreeBean {
  ProjectTreeBean({
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

  factory ProjectTreeBean.fromJson(Map<String, dynamic> json) => ProjectTreeBean(
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