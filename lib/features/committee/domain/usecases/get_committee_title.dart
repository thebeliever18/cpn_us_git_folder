import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/committee/data/models/committee_title_model.dart';
import 'package:cpn_us/features/committee/domain/repositories/committee_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetCommitteeTitleData implements UseCase<CommitteeTitleModel?,GetCommitteeTitleParams?>{
  final CommitteeRepository? repository;
  GetCommitteeTitleData(this.repository);

  @override
  Future<Either<Failures?,CommitteeTitleModel?>?>? call(GetCommitteeTitleParams? params) async{
    return await repository!.getCommitteeTitleData(params!.committeeTitleModel);
  }
}

class GetCommitteeTitleParams extends Equatable{
  final CommitteeTitleModel? committeeTitleModel;
  const GetCommitteeTitleParams({required this.committeeTitleModel});

  @override
  List<Object?> get props => [committeeTitleModel];
}