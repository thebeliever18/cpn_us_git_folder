import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:dartz/dartz.dart';
abstract class OnBoardingRepository {
  Future<Either<Failures?,OnBoardingModel?>?>? getOnBoardingData(OnBoardingModel? onBoardingModel);
}