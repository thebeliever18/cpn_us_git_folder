import 'package:equatable/equatable.dart';

class Images extends Equatable {
  final int? id;
  final String? url;
  final int? productId;
  final dynamic createdAt;
  final dynamic updatedAt;

  Images({
    this.id,
    this.url,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    url,
    productId,
    createdAt,
    updatedAt,
  ];
}
