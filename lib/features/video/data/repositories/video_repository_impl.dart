import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/network/network_info.dart';
import 'package:cpn_us/features/video/data/datasources/video_remote_data_source.dart';
import 'package:cpn_us/features/video/data/models/video_model.dart';
import 'package:cpn_us/features/video/domain/repositories/video_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<dynamic>? _RemoteOrLocalChooser();

class VideoRepoImpl implements VideoRepository{
  final VideoRemoteDataSource? videoRemoteDataSource;
  //TODO:[SPANDAN] final VideoLocalDataSource? _localDataSource;
  final NetworkInfo? networkInfo;
  VideoRepoImpl(
    {
      required this.videoRemoteDataSource,
      required this.networkInfo
    }
  );

  
 

  Future<Either<Failures,VideoModel?>> _getVideoData(_RemoteOrLocalChooser getRemoteOrLocal) async {
    //TODO:[SPANDAN] implement the concept of interceptor here

    if(await networkInfo!.isConnected==true){
      try{
        final remoteVideoData = await getRemoteOrLocal();
        return Right(remoteVideoData);
      }catch(e){
        return Left(ServerFailure());
      }
    }else{
      return Left(CacheFailure());
      //TODO:[SPANDAN] for local data source is yet be implemented
    }
  }

  @override
  Future<Either<Failures?, VideoModel?>?>? getVideoData(VideoModel? videoModel) async{
    return await _getVideoData(() => videoRemoteDataSource!.getVideoData(videoModel));
  }
}