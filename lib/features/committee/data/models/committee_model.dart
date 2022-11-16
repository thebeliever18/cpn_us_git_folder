// To parse this JSON data, do
//
//     final committeeModel = committeeModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/committee/domain/entities/committee.dart';

CommitteeModel committeeModelFromJson(String str) =>
    CommitteeModel.fromJson(json.decode(str));

String committeeModelToJson(CommitteeModel data) => json.encode(data.toJson());

class CommitteeModel {
  CommitteeModel({
    this.type,
    this.message,
    this.response,
  });

  final String? type;
  final String? message;
  final List<CommitteeModelResponse>? response;

  factory CommitteeModel.fromJson(Map<String, dynamic> json) => CommitteeModel(
        type: json["type"],
        message: json["message"],
        response: List<CommitteeModelResponse>.from(
            json["response"].map((x) => CommitteeModelResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class CommitteeModelResponse extends Committee {
  CommitteeModelResponse({
    super.cdetailsid,
    super.membername,
    super.address,
    super.position,
    super.mobilenumber,
    super.description,
    super.image,
  });

  factory CommitteeModelResponse.fromJson(Map<String, dynamic> json) => CommitteeModelResponse(
        cdetailsid: json['cdetailsid'],
        membername: json["membername"],
        address: json["address"],
        position: json["position"],
        mobilenumber: json["mobilenumber"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
            "cdetailsid":cdetailsid
      };
}
