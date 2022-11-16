// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/about_us/domain/entities/about_us.dart';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
    AboutUsModel({
        this.type,
        this.message,
        this.response,
    });

    final String? type;
    final String? message;
    final List<Response>? response;

    factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        type: json["type"],
        message: json["message"],
        response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class Response extends AboutUs{
    Response({
        super.aboutusid,
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
    });

    

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        aboutusid: json["aboutusid"],
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
    );

    Map<String, dynamic> toJson() => {
        "aboutusid": aboutusid,
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
    };
}
