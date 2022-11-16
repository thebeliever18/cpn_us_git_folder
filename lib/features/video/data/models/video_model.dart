// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/video/domain/entities/video.dart';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
    VideoModel({
        this.type,
        this.message,
        this.response,
    });

    final String? type;
    final String? message;
    final List<GridResponse>? response;

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        type: json["type"],
        message: json["message"],
        response: List<GridResponse>.from(json["response"].map((x) => GridResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class GridResponse extends Video{
    GridResponse({
        super.videoid,
        super.videolinked,
        super.status,
        super.postedby,
        super.modifiedby,
        super.posteddatetime,
        super.modifieddatetime,
        super.ipaddress,
        super.macaddress,
        super.latitude,
        super.longitude,
        super.title,
        super.image,
    });

 

    factory GridResponse.fromJson(Map<String, dynamic> json) => GridResponse(
        videoid: json["videoid"],
        videolinked: json["videolinked"],
        status: json["status"],
        postedby: json["postedby"],
        modifiedby: json["modifiedby"],
        posteddatetime: DateTime.parse(json["posteddatetime"]),
        modifieddatetime: json["modifieddatetime"],
        ipaddress: json["ipaddress"],
        macaddress: json["macaddress"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        title: json["title"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "videoid": videoid,
        "videolinked": videolinked,
        "status": status,
        "postedby": postedby,
        "modifiedby": modifiedby,
        "posteddatetime": posteddatetime!.toIso8601String(),
        "modifieddatetime": modifieddatetime,
        "ipaddress": ipaddress,
        "macaddress": macaddress,
        "latitude": latitude,
        "longitude": longitude,
        "title": title,
        "image": image,
    };
}
