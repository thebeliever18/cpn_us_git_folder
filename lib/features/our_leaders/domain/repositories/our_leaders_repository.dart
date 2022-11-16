import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:dartz/dartz.dart';
abstract class OurLeadersRepository {
  Future<Either<Failures?,OurLeadersModel?>?>? getOurLeadersData(OurLeadersModel? OurLeadersModel);
}