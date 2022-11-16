import 'package:equatable/equatable.dart';

class OurLeaders extends Equatable {
  final int? ourleaderid;
  final String? name;
  final String? position;
  final String? order;
  final String? image;
  final String? status;
  final dynamic postedby;
  final dynamic modifiedby;
  final DateTime? posteddatetime;
  final dynamic modifieddatetime;
  final dynamic ipaddress;
  final dynamic macaddress;
  final dynamic latitude;
  final dynamic longitude;

  OurLeaders({
    this.ourleaderid,
    this.name,
    this.position,
    this.order,
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
        ourleaderid,
        name,
        position,
        order,
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
