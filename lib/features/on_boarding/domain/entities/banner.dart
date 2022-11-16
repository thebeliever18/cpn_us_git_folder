import 'package:equatable/equatable.dart';

class BannerE extends Equatable {
  final int? bannerid;
  final String? bannername;
  final String? image;
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
  final int? newsid;
  final String? categoryId;
  final String? title;

  BannerE({
    this.bannerid,
    this.bannername,
    this.image,
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
    this.newsid,
    this.categoryId,
    this.title,
  });

  @override
  List<Object?> get props => [
        bannerid,
        bannername,
        image,
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
        newsid,
        categoryId,
        title,
      ];
}
