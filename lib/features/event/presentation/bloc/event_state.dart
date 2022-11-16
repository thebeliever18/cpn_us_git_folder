part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();
  
  @override
  List<Object?> get props => [];
}

class EventLoading extends EventState {}
class EventInitial extends EventState {}

class EventLoaded extends EventState {
  final int? pageIndex;
  final EventModel? eventModel;
  const EventLoaded({this.eventModel,this.pageIndex});
  @override
  List<Object?> get props => [EventModel,pageIndex];
}

class EventNotLoaded extends EventState {
  final String message;
  const EventNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}


class DownloadDataLoaded extends EventState{
  final DownloadModel downloadModel;
  const DownloadDataLoaded({required this.downloadModel});
  @override
  List<Object?> get props => [downloadModel];
}

class DownloadDataLoading extends EventState{
  final DownloadModel downloadModel;
  final EventModel eventModel;
  const DownloadDataLoading({required this.downloadModel,required this.eventModel});
  @override
  List<Object?> get props => [downloadModel,eventModel];
}