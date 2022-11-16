import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:dartz/dartz.dart';
abstract class NoticesRepository {
  Future<Either<Failures?,NoticesModel?>?>? getNoticesData(NoticesModel? noticesModel);
}