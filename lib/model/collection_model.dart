// To parse this JSON data, do
//
//     final collectionModel = collectionModelFromJson(jsonString);

import 'dart:convert';

CollectionModel collectionModelFromJson(String str) => CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) => json.encode(data.toJson());

class CollectionModel {
  CollectionModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  CollectionModelData data;
  int errorCode;
  String errorMsg;

  factory CollectionModel.fromJson(Map<String, dynamic> json) => CollectionModel(
    data: CollectionModelData.fromJson(json["data"]),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class CollectionModelData {
  CollectionModelData({
    required this.curPage,
    required this.datas,
    required this.offset,
    required this.over,
    required this.pageCount,
    required this.size,
    required this.total,
  });

  int curPage;
  List<CollectionBean> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  factory CollectionModelData.fromJson(Map<String, dynamic> json) => CollectionModelData(
    curPage: json["curPage"],
    datas: List<CollectionBean>.from(json["datas"].map((x) => CollectionBean.fromJson(x))),
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

class CollectionBean {
  CollectionBean({
    required this.author,
    required this.chapterId,
    required this.chapterName,
    required this.courseId,
    required this.desc,
    required this.envelopePic,
    required this.id,
    required this.link,
    required this.niceDate,
    required this.origin,
    required this.originId,
    required this.publishTime,
    required this.title,
    required this.userId,
    required this.visible,
    required this.zan,
  });

  String author;
  int chapterId;
  String chapterName;
  int courseId;
  String desc;
  String envelopePic;
  int id;
  String link;
  String niceDate;
  String origin;
  int originId;
  int publishTime;
  String title;
  int userId;
  int visible;
  int zan;

  factory CollectionBean.fromJson(Map<String, dynamic> json) => CollectionBean(
    author: json["author"],
    chapterId: json["chapterId"],
    chapterName: json["chapterName"],
    courseId: json["courseId"],
    desc: json["desc"],
    envelopePic: json["envelopePic"],
    id: json["id"],
    link: json["link"],
    niceDate: json["niceDate"],
    origin: json["origin"],
    originId: json["originId"],
    publishTime: json["publishTime"],
    title: json["title"],
    userId: json["userId"],
    visible: json["visible"],
    zan: json["zan"],
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "chapterId": chapterId,
    "chapterName": chapterName,
    "courseId": courseId,
    "desc": desc,
    "envelopePic": envelopePic,
    "id": id,
    "link": link,
    "niceDate": niceDate,
    "origin": origin,
    "originId": originId,
    "publishTime": publishTime,
    "title": title,
    "userId": userId,
    "visible": visible,
    "zan": zan,
  };
}