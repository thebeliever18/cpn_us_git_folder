// To parse this JSON data, do
//
//     final committeeTitleModel = committeeTitleModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/committee/domain/entities/committee_title.dart';

CommitteeTitleModel committeeTitleModelFromJson(String str) => CommitteeTitleModel.fromJson(json.decode(str));

String committeeTitleModelToJson(CommitteeTitleModel data) => json.encode(data.toJson());

class CommitteeTitleModel {
    CommitteeTitleModel({
        this.type,
        this.message,
        this.response,
    });

    final String? type;
    final String? message;
    final List<CommitteeTitleResponse>? response;

    factory CommitteeTitleModel.fromJson(Map<String, dynamic> json) => CommitteeTitleModel(
        type: json["type"],
        message: json["message"],
        response: List<CommitteeTitleResponse>.from(json["response"].map((x) => CommitteeTitleResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class CommitteeTitleResponse extends CommitteeTitle{
    CommitteeTitleResponse({
        super.ctitleid,
        super.title,
        super.description
    });
    
    factory CommitteeTitleResponse.fromJson(Map<String, dynamic> json) => CommitteeTitleResponse(
        ctitleid: json["ctitleid"],
        title: json["title"],
        description:json["description"]
    );

    Map<String, dynamic> toJson() => {
        "ctitleid": ctitleid,
        "title": title,
    };
}
