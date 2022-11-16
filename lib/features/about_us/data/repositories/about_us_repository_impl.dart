import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/about_us/data/datasources/about_us_remote_data_source.dart';
import 'package:cpn_us/features/about_us/data/models/about_us_model.dart';
import 'package:cpn_us/features/about_us/domain/repositories/about_us_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class AboutUsRepoImpl implements AboutUsRepository{
  final AboutUsRemoteDataSource? aboutUsRemoteDataSource;
  //TODO:[SPANDAN] final AboutUsLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  AboutUsRepoImpl(
    {
      required this.aboutUsRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,AboutUsModel?>> _getAboutUsData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteAboutUsData = await getRemoteOrLocal();
        return Right(remoteAboutUsData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, AboutUsModel?>?>? getAboutUsData(AboutUsModel? aboutUsModel) async{
    return await _getAboutUsData(() => aboutUsRemoteDataSource!.getAboutUsData(aboutUsModel));
  }
}