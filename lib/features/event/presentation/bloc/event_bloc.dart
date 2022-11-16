
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/event/data/models/download_model.dart';
import 'package:cpn_us/features/event/data/models/event_model.dart';
import 'package:cpn_us/features/event/domain/entities/download.dart';
import 'package:cpn_us/features/event/domain/usecases/get_download_data.dart';
import 'package:cpn_us/features/event/domain/usecases/get_event_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'event_event.dart';
part 'event_state.dart';


class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEventData getEventData;
  final GetDownloadData getDownloadData;

  EventModel? _datum;
  EventModel? get datum => _datum;

  EventBloc({required this.getEventData,required this.getDownloadData}) : super(EventLoading()) {
    on<TriggerEventPostApi>(_onTriggerEventPostApi);
     on<DownloadFile>(_onDownloadFile);
  }

  void _onTriggerEventPostApi(
      TriggerEventPostApi event, Emitter<EventState> emit) async {
    final failureOrEventData = await getEventData(
        GetEventParams(eventModel: event.eventModel));
    emit(_eitherLoadedOrErrorState(failureOrEventData));
  }

  EventState _eitherLoadedOrErrorState(
      Either<Failures?, EventModel?>? failureOrEventData) {
    return failureOrEventData!.fold(
        (failure) => EventNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (eventModel) {
          _datum=eventModel;
      return EventLoaded(eventModel:eventModel,pageIndex: 3);
    });
  }

  

  void _onDownloadFile(DownloadFile event, Emitter<EventState> emit) async{
    emit(DownloadDataLoading(
      eventModel: datum!,
      downloadModel: DownloadModel(downloadStatus: DownloadStatus.progress,
      downloadFileName: event.downloadModel.downloadFileName
      ), ),);
     final failureOrEventData = await getDownloadData(
        GetDownloadParams(downloadModel: event.downloadModel));
    emit(_downloadEitherLoadedOrErrorState(failureOrEventData));
  }

  EventState _downloadEitherLoadedOrErrorState(
      Either<Failures?, DownloadModel?>? failureOrEventData) {
    return failureOrEventData!.fold(
        (failure) => EventNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (downloadModel) {
      return EventLoaded(eventModel: datum,pageIndex: 3);
    });
  }
}
