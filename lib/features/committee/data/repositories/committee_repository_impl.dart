import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/committee/data/datasources/committee_remote_data_source.dart';
import 'package:cpn_us/features/committee/data/models/committee_model.dart';
import 'package:cpn_us/features/committee/data/models/committee_title_model.dart';
import 'package:cpn_us/features/committee/domain/repositories/committee_repository.dart';

import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class CommitteeRepoImpl implements CommitteeRepository{
  final CommitteeRemoteDataSource? committeeRemoteDataSource;
  //TODO:[SPANDAN] final CommitteeLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  CommitteeRepoImpl(
    {
      required this.committeeRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,CommitteeModel?>> _getCommitteeData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteCommitteeData = await getRemoteOrLocal();
        return Right(remoteCommitteeData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, CommitteeModel?>?>? getCommitteeData(CommitteeModel? committeeModel) async{
    return await _getCommitteeData(() => committeeRemoteDataSource!.getCommitteeData(committeeModel));
  }

  @override
  Future<Either<Failures?, CommitteeTitleModel?>?>? getCommitteeTitleData(CommitteeTitleModel? committeeTitleModel) async{
    return await _getCommitteeTitleData(() => committeeRemoteDataSource!.getCommitteeTitleData(committeeTitleModel));
  }


  Future<Either<Failures,CommitteeTitleModel?>> _getCommitteeTitleData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteCommitteeTitleData = await getRemoteOrLocal();
        return Right(remoteCommitteeTitleData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }
}