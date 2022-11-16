
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/notices/data/models/notices_model.dart';
import 'package:cpn_us/features/notices/domain/usecases/get_notices_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'notices_event.dart';
part 'notices_state.dart';


class NoticesBloc extends Bloc<NoticesEvent, NoticesState> {
  final GetNoticesData getNoticesData;


  NoticesBloc({required this.getNoticesData}) : super(NoticesLoading()) {
    on<TriggerNoticesPostApi>(_onTriggerNoticesPostApi);
  }

  void _onTriggerNoticesPostApi(
      TriggerNoticesPostApi event, Emitter<NoticesState> emit) async {
    final failureOrNoticesData = await getNoticesData(
        GetNoticesParams(noticesModel: event.noticesModel));
    emit(_eitherLoadedOrErrorState(failureOrNoticesData));
  }

  NoticesState _eitherLoadedOrErrorState(
      Either<Failures?, NoticesModel?>? failureOrNoticesData) {
    return failureOrNoticesData!.fold(
        (failure) => NoticesNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (noticesModel) {
      return NoticesLoaded(noticesModel:noticesModel);
    });
  }
}
