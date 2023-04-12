// To parse this JSON data, do
//
//     final baseModel = baseModelFromJson(jsonString);

import 'dart:convert';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  BaseModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  String data;
  int errorCode;
  String errorMsg;

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
    data: json["data"],
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}