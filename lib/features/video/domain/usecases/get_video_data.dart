import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/usecases/usecase.dart';
import 'package:cpn_us/features/video/data/models/video_model.dart';
import 'package:cpn_us/features/video/domain/repositories/video_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';



class GetVideoData implements UseCase<VideoModel?,GetVideoParams?>{
  final VideoRepository? repository;
  GetVideoData(this.repository);

  @override
  Future<Either<Failures?,VideoModel?>?>? call(GetVideoParams? params) async{
    return await repository!.getVideoData(params!.videoModel);
  }
}

class GetVideoParams extends Equatable{
  final VideoModel? videoModel;
  const GetVideoParams({required this.videoModel});

  @override
  List<Object?> get props => [VideoModel];
}