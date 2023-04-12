// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  UserInfoModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  Data data;
  int errorCode;
  String errorMsg;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    data: Data.fromJson(json["data"]),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class Data {
  Data({
    required this.coinCount,
    required this.level,
    required this.nickname,
    required this.rank,
    required this.userId,
    required this.username,
  });

  int coinCount;
  int level;
  String nickname;
  String rank;
  int userId;
  String username;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    coinCount: json["coinCount"],
    level: json["level"],
    nickname: json["nickname"],
    rank: json["rank"],
    userId: json["userId"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "coinCount": coinCount,
    "level": level,
    "nickname": nickname,
    "rank": rank,
    "userId": userId,
    "username": username,
  };
}