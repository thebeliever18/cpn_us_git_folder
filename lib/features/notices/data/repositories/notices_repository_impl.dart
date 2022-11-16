import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/notices/data/datasources/notices_remote_data_source.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:cpn_us/features/notices/domain/repositories/notices_repository.dart';

import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class NoticesRepoImpl implements NoticesRepository{
  final NoticesRemoteDataSource? noticesRemoteDataSource;
  //TODO:[SPANDAN] final NoticesLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  NoticesRepoImpl(
    {
      required this.noticesRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,NoticesModel?>> _getNoticesData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteNoticesData = await getRemoteOrLocal();
        return Right(remoteNoticesData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, NoticesModel?>?>? getNoticesData(NoticesModel? noticesModel) async{
    return await _getNoticesData(() => noticesRemoteDataSource!.getNoticesData(noticesModel));
  }
}