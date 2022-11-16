import 'package:equatable/equatable.dart';

class Committee extends Equatable {
  final int? cdetailsid;
  final String? membername;
  final String? address;
  final String? position;
  final String? mobilenumber;
  final String? description;
  final String? image;

  Committee({
    this.cdetailsid,
    this.membername,
    this.address,
    this.position,
    this.mobilenumber,
    this.description,
    this.image,
  });

  @override
  List<Object?> get props => [
        cdetailsid,
        membername,
        address,
        position,
        mobilenumber,
        description,
        image,
      ];
}
