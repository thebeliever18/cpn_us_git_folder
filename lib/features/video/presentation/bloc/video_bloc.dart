
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/video/data/models/video_model.dart';
import 'package:cpn_us/features/video/domain/usecases/get_video_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'video_event.dart';
part 'video_state.dart';


class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetVideoData getVideoData;


  VideoBloc({required this.getVideoData}) : super(VideoLoading()) {
    on<TriggerVideoPostApi>(_onTriggerVideoPostApi);
  }

  void _onTriggerVideoPostApi(
      TriggerVideoPostApi event, Emitter<VideoState> emit) async {
    final failureOrVideoData = await getVideoData(
        GetVideoParams(videoModel: event.videoModel));
    emit(_eitherLoadedOrErrorState(failureOrVideoData));
  }

  VideoState _eitherLoadedOrErrorState(
      Either<Failures?, VideoModel?>? failureOrVideoData) {
    return failureOrVideoData!.fold(
        (failure) => VideoNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (videoModel) {
      return VideoLoaded(videoModel:videoModel);
    });
  }
}
