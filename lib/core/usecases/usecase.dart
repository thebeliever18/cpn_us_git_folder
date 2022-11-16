import 'package:cpn_us/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failures?,Type?>?>? call(Params params);
}

class NoParams extends Equatable{
  @override
  List<Object?> get props => [];
}