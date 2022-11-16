import 'package:equatable/equatable.dart';

class Gallery extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Gallery({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        createdAt,
        updatedAt,
      ];
}
