import 'package:equatable/equatable.dart';

class Notices extends Equatable {
  final int? noticeid;
  final String? title;
  final String? description;
  final String? status;
  final DateTime? posteddatetime;
  final String? image;

  Notices({
    this.noticeid,
    this.title,
    this.description,
    this.status,
    this.posteddatetime,
    this.image,
  });

  @override
  List<Object?> get props => [
        noticeid,
        title,
        description,
        status,
        posteddatetime,
        image,
      ];
}
