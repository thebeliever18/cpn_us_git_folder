part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object?> get props => [];
}

class TriggerEventPostApi extends EventEvent{
  final EventModel eventModel;
  const TriggerEventPostApi({required this.eventModel});
  @override
  List<Object?> get props => [eventModel];
}

class DownloadFile extends EventEvent{
  final DownloadModel downloadModel;
  const DownloadFile({required this.downloadModel});
  @override
  List<Object?> get props => [downloadModel];
}