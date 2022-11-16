import 'package:equatable/equatable.dart';

class AboutUs extends Equatable {
  final int? aboutusid;
  final String? description;
  final String? status;
  final dynamic postedby;
  final dynamic modifiedby;
  final DateTime? posteddatetime;
  final dynamic modifieddatetime;
  final dynamic ipaddress;
  final dynamic macaddress;
  final dynamic latitude;
  final dynamic longitude;

  AboutUs({
    this.aboutusid,
    this.description,
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
        aboutusid,
        description,
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
