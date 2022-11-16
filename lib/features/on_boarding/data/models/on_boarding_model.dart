// To parse this JSON data, do
//
//     final onBoardingModel = onBoardingModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/on_boarding/domain/entities/banner.dart';
import 'package:cpn_us/features/on_boarding/domain/entities/on_boarding.dart';

OnBoardingModel onBoardingModelFromJson(String str) =>
    OnBoardingModel.fromJson(json.decode(str));

String onBoardingModelToJson(OnBoardingModel data) =>
    json.encode(data.toJson());

class OnBoardingModel {
  OnBoardingModel({
    this.type,
    this.message,
    this.response,
  });

  final String? type;
  final String? message;
  final Response? response;

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) =>
      OnBoardingModel(
        type: json["type"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": response!.toJson(),
      };
}

class Response {
  Response({
    this.banner,
    this.news,
  });

  final List<Banner>? banner;
  final List<News>? news;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        banner:
            List<Banner>.from(json["banner"].map((x) => Banner.fromJson(x))),
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banner": List<dynamic>.from(banner!.map((x) => x.toJson())),
        "news": List<dynamic>.from(news!.map((x) => x.toJson())),
      };
}

class Banner extends BannerE{
  Banner({
    super.bannerid,
    super.bannername,
    super.image,
    super.description,
    super.status,
    super.postedby,
    super.modifiedby,
    super.posteddatetime,
    super.modifieddatetime,
    super.ipaddress,
    super.macaddress,
    super.latitude,
    super.longitude,
    super.newsid,
    super.categoryId,
    super.title,
  });



  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        bannerid: json["bannerid"] == null ? null : json["bannerid"],
        bannername: json["bannername"] == null ? null : json["bannername"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        postedby: json["postedby"],
        modifiedby: json["modifiedby"],
        posteddatetime: DateTime.parse(json["posteddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        ipaddress: json["ipaddress"],
        macaddress: json["macaddress"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        newsid: json["newsid"] == null ? null : json["newsid"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "bannerid": bannerid == null ? null : bannerid,
        "bannername": bannername == null ? null : bannername,
        "image": image,
        "description": description,
        "status": status,
        "postedby": postedby,
        "modifiedby": modifiedby,
        "posteddatetime": posteddatetime!.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "ipaddress": ipaddress,
        "macaddress": macaddress,
        "latitude": latitude,
        "longitude": longitude,
        "newsid": newsid == null ? null : newsid,
        "category_id": categoryId == null ? null : categoryId,
        "title": title == null ? null : title,
      };
}

class News extends OnBoarding{
  News({
    super.newsid,
    super.categoryId,
    super.title,
    super.description,
    super.image,
    super.status,
    super.postedby,
    super.modifiedby,
    super.posteddatetime,
    super.modifieddatetime,
    super.ipaddress,
    super.macaddress,
    super.latitude,
    super.longitude,
  });

 

  factory News.fromJson(Map<String, dynamic> json) => News(
        image: json["image"],
        description: json["description"],
        status: json["status"],
        postedby: json["postedby"],
        modifiedby: json["modifiedby"],
        posteddatetime: DateTime.parse(json["posteddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        ipaddress: json["ipaddress"],
        macaddress: json["macaddress"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        newsid: json["newsid"] == null ? null : json["newsid"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "description": description,
        "status": status,
        "postedby": postedby,
        "modifiedby": modifiedby,
        "posteddatetime": posteddatetime!.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "ipaddress": ipaddress,
        "macaddress": macaddress,
        "latitude": latitude,
        "longitude": longitude,
        "newsid": newsid == null ? null : newsid,
        "category_id": categoryId == null ? null : categoryId,
        "title": title == null ? null : title,
      };
}
