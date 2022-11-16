import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/committee/data/models/committee_model.dart';
import 'package:cpn_us/features/committee/data/models/committee_title_model.dart';
import 'package:dartz/dartz.dart';
abstract class CommitteeRepository {
  Future<Either<Failures?,CommitteeModel?>?>? getCommitteeData(CommitteeModel? committeeModel);
  Future<Either<Failures?,CommitteeTitleModel?>?>? getCommitteeTitleData(CommitteeTitleModel? committeeTitleModel);
}