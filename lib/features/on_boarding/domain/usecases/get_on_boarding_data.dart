import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:cpn_us/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetOnBoardingData implements UseCase<OnBoardingModel?,GetOnBoardingParams?>{
  final OnBoardingRepository? repository;
  GetOnBoardingData(this.repository);

  @override
  Future<Either<Failures?,OnBoardingModel?>?>? call(GetOnBoardingParams? params) async{
    return await repository!.getOnBoardingData(params!.onBoardingModel);
  }
}

class GetOnBoardingParams extends Equatable{
  final OnBoardingModel? onBoardingModel;
  const GetOnBoardingParams({required this.onBoardingModel});

  @override
  List<Object?> get props => [onBoardingModel];
}