import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/our_leaders/data/datasources/our_leaders_remote_data_source.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:cpn_us/features/our_leaders/domain/repositories/our_leaders_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class OurLeadersRepoImpl implements OurLeadersRepository{
  final OurLeadersRemoteDataSource? ourLeadersRemoteDataSource;
  //TODO:[SPANDAN] final OurLeadersLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  OurLeadersRepoImpl(
    {
      required this.ourLeadersRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,OurLeadersModel?>> _getOurLeadersData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteOurLeadersData = await getRemoteOrLocal();
        return Right(remoteOurLeadersData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, OurLeadersModel?>?>? getOurLeadersData(OurLeadersModel? ourLeadersModel) async{
    return await _getOurLeadersData(() => ourLeadersRemoteDataSource!.getOurLeadersData(ourLeadersModel));
  }
}