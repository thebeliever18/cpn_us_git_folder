import 'package:equatable/equatable.dart';

class CommitteeTitle extends Equatable {
  final int? ctitleid;
  final String? title;
  final String? description;
  CommitteeTitle({this.ctitleid, this.title,this.description});

  @override
  List<Object?> get props => [ctitleid, title,description];
}
