import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/features/video/data/models/video_model.dart';
import 'package:dartz/dartz.dart';
abstract class VideoRepository {
  Future<Either<Failures?,VideoModel?>?>? getVideoData(VideoModel? videoModel);
}