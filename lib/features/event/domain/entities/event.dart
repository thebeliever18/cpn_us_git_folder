import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final int? eventid;
  final String? file;
  final String? eventdate;
  final String? title;
  final String? description;
  final dynamic image;
  final String? status;
  final dynamic postedby;
  final dynamic modifiedby;
  final DateTime? posteddatetime;
  final dynamic modifieddatetime;
  final dynamic ipaddress;
  final dynamic macaddress;
  final dynamic latitude;
  final dynamic longitude;
  

  Event({
    this.eventid,
    this.file,
    this.eventdate,
    this.title,
    this.description,
    this.image,
    this.status,
    this.postedby,
    this.modifiedby,
    this.posteddatetime,
    this.modifieddatetime,
    this.ipaddress,
    this.macaddress,
    this.latitude,
    this.longitude,
    
  });

  @override
  List<Object?> get props => [
        eventid,
        file,
        eventdate,
        title,
        description,
        image,
        status,
        postedby,
        modifiedby,
        posteddatetime,
        modifieddatetime,
        ipaddress,
        macaddress,
        latitude,
        longitude,
      ];
}
