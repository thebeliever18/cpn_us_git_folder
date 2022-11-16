import 'package:equatable/equatable.dart';

class OnBoarding extends Equatable {
  
  final int? newsid;
  final String? categoryId;
  final String? title;
  final String? description;
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

  OnBoarding({
    this.newsid,
    this.categoryId,
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
  List<Object?> get props =>[
    newsid,
    categoryId,
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
