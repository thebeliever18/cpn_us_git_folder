import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final int? videoid;
  final String? videolinked;
  final String? status;
  final dynamic postedby;
  final dynamic modifiedby;
  final DateTime? posteddatetime;
  final dynamic modifieddatetime;
  final dynamic ipaddress;
  final dynamic macaddress;
  final dynamic latitude;
  final dynamic longitude;
  final String? title;
  final String? image;

  Video({
    this.videoid,
    this.videolinked,
    this.status,
    this.postedby,
    this.modifiedby,
    this.posteddatetime,
    this.modifieddatetime,
    this.ipaddress,
    this.macaddress,
    this.latitude,
    this.longitude,
    this.title,
    this.image,
  });

  @override
  List<Object?> get props => [
        videoid,
        videolinked,
        status,
        postedby,
        modifiedby,
        posteddatetime,
        modifieddatetime,
        ipaddress,
        macaddress,
        latitude,
        longitude,
        title,
        image,
      ];
}
