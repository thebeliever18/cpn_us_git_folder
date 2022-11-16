part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();
  
  @override
  List<Object?> get props => [];
}

class VideoLoading extends VideoState {}
class VideoInitial extends VideoState {}

class VideoLoaded extends VideoState {
  final int? pageIndex;
  final VideoModel? videoModel;
  const VideoLoaded({this.videoModel,this.pageIndex});
  @override
  List<Object?> get props => [videoModel,pageIndex];
}

class VideoNotLoaded extends VideoState {
  final String message;
  const VideoNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}
