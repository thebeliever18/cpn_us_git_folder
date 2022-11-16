part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

class TriggerVideoPostApi extends VideoEvent{
  final VideoModel videoModel;
  const TriggerVideoPostApi({required this.videoModel});
  @override
  List<Object?> get props => [videoModel];
}