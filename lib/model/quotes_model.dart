import 'dart:convert';

QuotesModel quotesModelFromJson(String str) =>
    QuotesModel.fromJson(json.decode(str));

//List<Datum> datumFromJson(String str) => List<Datum>.fromJson(json.decode(str));

String quotesModelToJson(QuotesModel data) => json.encode(data.toJson());

class QuotesModel {
  QuotesModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Datum>? data;

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.quotesContent,
    this.categoryId,
    this.categoryName,
    this.languagesCode,
    this.languages,
  });

  String? id;
  String? quotesContent;
  String? categoryId;
  String? categoryName;
  String? languagesCode;
  String? languages;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        quotesContent: json["quotesContent"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        languagesCode: json["languagesCode"],
        languages: json["languages"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quotesContent": quotesContent,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "languagesCode": languagesCode,
        "languages": languages,
      };
}
