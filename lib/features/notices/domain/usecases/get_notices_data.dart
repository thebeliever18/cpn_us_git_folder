import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:cpn_us/features/notices/domain/repositories/notices_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetNoticesData implements UseCase<NoticesModel?,GetNoticesParams?>{
  final NoticesRepository? repository;
  GetNoticesData(this.repository);

  @override
  Future<Either<Failures?,NoticesModel?>?>? call(GetNoticesParams? params) async{
    return await repository!.getNoticesData(params!.noticesModel);
  }
}

class GetNoticesParams extends Equatable{
  final NoticesModel? noticesModel;
  const GetNoticesParams({required this.noticesModel});

  @override
  List<Object?> get props => [noticesModel];
}