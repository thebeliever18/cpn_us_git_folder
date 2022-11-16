import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/committee/data/models/committee_model.dart';
import 'package:cpn_us/features/committee/domain/repositories/committee_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetCommitteeData implements UseCase<CommitteeModel?,GetCommitteeParams?>{
  final CommitteeRepository? repository;
  GetCommitteeData(this.repository);

  @override
  Future<Either<Failures?,CommitteeModel?>?>? call(GetCommitteeParams? params) async{
    return await repository!.getCommitteeData(params!.committeeModel);
  }
}

class GetCommitteeParams extends Equatable{
  final CommitteeModel? committeeModel;
  const GetCommitteeParams({required this.committeeModel});

  @override
  List<Object?> get props => [committeeModel];
}