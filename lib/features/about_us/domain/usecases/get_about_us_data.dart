import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/about_us/data/models/about_us_model.dart';
import 'package:cpn_us/features/about_us/domain/repositories/about_us_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetAboutUsData implements UseCase<AboutUsModel?,GetAboutUsParams?>{
  final AboutUsRepository? repository;
  GetAboutUsData(this.repository);

  @override
  Future<Either<Failures?,AboutUsModel?>?>? call(GetAboutUsParams? params) async{
    return await repository!.getAboutUsData(params!.aboutUsModel);
  }
}

class GetAboutUsParams extends Equatable{
  final AboutUsModel? aboutUsModel;
  const GetAboutUsParams({required this.aboutUsModel});

  @override
  List<Object?> get props => [aboutUsModel];
}