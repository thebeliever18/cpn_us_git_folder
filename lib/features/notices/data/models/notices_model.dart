// To parse this JSON data, do
//
//     final noticesModel = noticesModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/notices/domain/entities/notices.dart';

NoticesModel noticesModelFromJson(String str) => NoticesModel.fromJson(json.decode(str));

String noticesModelToJson(NoticesModel data) => json.encode(data.toJson());

class NoticesModel {
    NoticesModel({
        this.type,
        this.message,
        this.response,
    });

    final String? type;
    final String? message;
    final List<NoticeResponse>? response;

    factory NoticesModel.fromJson(Map<String, dynamic> json) => NoticesModel(
        type: json["type"],
        message: json["message"],
        response: List<NoticeResponse>.from(json["response"].map((x) => NoticeResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class NoticeResponse extends Notices{
    NoticeResponse({
        super.noticeid,
        super.title,
        super.description,
        super.status,
        super.posteddatetime,
        super.image,
    });



    factory NoticeResponse.fromJson(Map<String, dynamic> json) => NoticeResponse(
        noticeid: json["noticeid"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        posteddatetime: DateTime.parse(json["posteddatetime"]),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "noticeid": noticeid,
        "title": title,
        "description": description,
        "status": status,
        "posteddatetime": posteddatetime!.toIso8601String(),
        "image": image,
    };
}
