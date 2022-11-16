// To parse this JSON data, do
//
//     final galleryModel = galleryModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/gallery/domain/entities/gallery.dart';

GalleryModel galleryModelFromJson(String str) => GalleryModel.fromJson(json.decode(str));

String galleryModelToJson(GalleryModel data) => json.encode(data.toJson());

class GalleryModel {
    GalleryModel({
        this.type,
        this.message,
        this.response,
    });

    final String? type;
    final String? message;
    final List<GalleryModelResponse>? response;

    factory GalleryModel.fromJson(Map<String, dynamic> json) => GalleryModel(
        type: json["type"],
        message: json["message"],
        response: List<GalleryModelResponse>.from(json["response"].map((x) => GalleryModelResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class GalleryModelResponse extends Gallery{
    GalleryModelResponse({
        super.id,
        super.name,
        super.description,
        super.createdAt,
        super.updatedAt,
    });

    

    factory GalleryModelResponse.fromJson(Map<String, dynamic> json) => GalleryModelResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
