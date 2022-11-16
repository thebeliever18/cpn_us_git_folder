// To parse this JSON data, do
//
//     final ourLeadersModel = ourLeadersModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/our_leaders/domain/entities/our_leaders.dart';

OurLeadersModel ourLeadersModelFromJson(String str) =>
    OurLeadersModel.fromJson(json.decode(str));

String ourLeadersModelToJson(OurLeadersModel data) =>
    json.encode(data.toJson());

class OurLeadersModel {
  OurLeadersModel({
    this.type,
    this.message,
    this.response,
  });

  final String? type;
  final String? message;
  final List<LeaderResponse>? response;

  factory OurLeadersModel.fromJson(Map<String, dynamic> json) =>
      OurLeadersModel(
        type: json["type"],
        message: json["message"],
        response: List<LeaderResponse>.from(
            json["response"].map((x) => LeaderResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class LeaderResponse extends OurLeaders {
  LeaderResponse({
    super.ourleaderid,
    super.name,
    super.position,
    super.order,
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

  factory LeaderResponse.fromJson(Map<String, dynamic> json) => LeaderResponse(
        ourleaderid: json["ourleaderid"],
        name: json["name"],
        position: json["position"],
        order: json["order"],
        image: json["image"],
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
        "ourleaderid": ourleaderid,
        "name": name,
        "position": position,
        "order": order,
        "image": image,
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
