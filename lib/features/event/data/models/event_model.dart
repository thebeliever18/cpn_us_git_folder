// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

import 'package:cpn_us/features/event/domain/entities/event.dart';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
    EventModel({
        this.type,
        this.message,
        this.response,
    });

    final String? type;
    final String? message;
    final List<EventResponse>? response;

    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        type: json["type"],
        message: json["message"],
        response: List<EventResponse>.from(json["response"].map((x) => EventResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
    };
}

class EventResponse extends Event{
    EventResponse({
        super.eventid,
        super.file,
        super.eventdate,
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

 

    factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
        eventid: json["eventid"],
        file: json["file"],
        eventdate: json["eventdate"],
        title: json["title"],
        description: json["description"],
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
        
    };
}
