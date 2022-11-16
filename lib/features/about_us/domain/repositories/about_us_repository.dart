import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/about_us/data/models/about_us_model.dart';
import 'package:dartz/dartz.dart';
abstract class AboutUsRepository {
  Future<Either<Failures?,AboutUsModel?>?>? getAboutUsData(AboutUsModel? aboutUsModel);
}