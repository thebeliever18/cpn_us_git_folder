// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/gallery/domain/entities/image.dart';

ImagesModel imageModelFromJson(String str) => ImagesModel.fromJson(json.decode(str));

String imageModelToJson(ImagesModel data) => json.encode(data.toJson());

class ImagesModel {
    ImagesModel({
        this.type,
        this.message,
        this.response,
    });

    final String? type;
    final String? message;
    final List<ImageResponse>? response;

    factory ImagesModel.fromJson(Map<String, dynamic> json) => ImagesModel(
        type: json["type"],
        message: json["message"],
        response: List<ImageResponse>.from(json["response"].map((x) => ImageResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class ImageResponse extends Images{
    ImageResponse({
        super.id,
        super.url,
        super.productId,
        super.createdAt,
        super.updatedAt,
    });

    factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        id: json["id"],
        url: json["url"],
        productId: json["product_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id.toString(),
    };
}
