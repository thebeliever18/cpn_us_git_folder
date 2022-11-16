import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/event/data/datasources/event_remote_data_source.dart';
import 'package:cpn_us/features/event/data/models/download_model.dart';
import 'package:cpn_us/features/event/data/models/event_model.dart';
import 'package:cpn_us/features/event/domain/repositories/event_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class EventRepoImpl implements EventRepository{
  final EventRemoteDataSource? eventRemoteDataSource;
  //TODO:[SPANDAN] final EventLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  EventRepoImpl(
    {
      required this.eventRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,EventModel?>> _getEventData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteEventData = await getRemoteOrLocal();
        return Right(remoteEventData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  Future<Either<Failures,DownloadModel?>> _getDownloadData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteDownloadData = await getRemoteOrLocal();
        return Right(remoteDownloadData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, EventModel?>?>? getEventData(EventModel? eventModel) async{
    return await _getEventData(() => eventRemoteDataSource!.getEventData(eventModel));
  }

  @override
  Future<Either<Failures?, DownloadModel?>?>? getDownloadData(DownloadModel? downloadModel) async{
    return await _getDownloadData(() => eventRemoteDataSource!.getDownloadData(downloadModel));
  }
}