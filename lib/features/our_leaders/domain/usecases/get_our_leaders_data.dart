import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:cpn_us/features/our_leaders/domain/repositories/our_leaders_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetOurLeadersData implements UseCase<OurLeadersModel?,GetOurLeadersParams?>{
  final OurLeadersRepository? repository;
  GetOurLeadersData(this.repository);

  @override
  Future<Either<Failures?,OurLeadersModel?>?>? call(GetOurLeadersParams? params) async{
    return await repository!.getOurLeadersData(params!.ourLeadersModel);
  }
}

class GetOurLeadersParams extends Equatable{
  final OurLeadersModel? ourLeadersModel;
  const GetOurLeadersParams({required this.ourLeadersModel});

  @override
  List<Object?> get props => [ourLeadersModel];
}