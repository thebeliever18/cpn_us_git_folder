import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/on_boarding/data/datasources/on_boarding_remote_data_source.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:cpn_us/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class OnBoardingRepoImpl implements OnBoardingRepository{
  final OnBoardingRemoteDataSource? onBoardingRemoteDataSource;
  //TODO:[SPANDAN] final OnBoardingLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  OnBoardingRepoImpl(
    {
      required this.onBoardingRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,OnBoardingModel?>> _getOnBoardingData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteOnBoardingData = await getRemoteOrLocal();
        return Right(remoteOnBoardingData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, OnBoardingModel?>?>? getOnBoardingData(OnBoardingModel? OnBoardingModel) async{
    return await _getOnBoardingData(() => onBoardingRemoteDataSource!.getOnBoardingData(OnBoardingModel));
  }
}