// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  String? type;
  String? message;
  String? answer;

  DataModel({
    this.type,
    this.message,
    this.answer,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
      };
}
