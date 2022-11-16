
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/our_leaders/data/models/our_leaders_model.dart';
import 'package:cpn_us/features/our_leaders/domain/usecases/get_our_leaders_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'our_leaders_event.dart';
part 'our_leaders_state.dart';


class OurLeadersBloc extends Bloc<OurLeadersEvent, OurLeadersState> {
  final GetOurLeadersData getOurLeadersData;


  OurLeadersBloc({required this.getOurLeadersData}) : super(OurLeadersLoading()) {
    on<TriggerOurLeadersPostApi>(_onTriggerOurLeadersPostApi);
  }

  void _onTriggerOurLeadersPostApi(
      TriggerOurLeadersPostApi event, Emitter<OurLeadersState> emit) async {
    final failureOrOurLeadersData = await getOurLeadersData(
        GetOurLeadersParams(ourLeadersModel: event.ourLeadersModel));
    emit(_eitherLoadedOrErrorState(failureOrOurLeadersData));
  }

  OurLeadersState _eitherLoadedOrErrorState(
      Either<Failures?, OurLeadersModel?>? failureOrOurLeadersData) {
    return failureOrOurLeadersData!.fold(
        (failure) => OurLeadersNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (ourLeadersModel) {
      return OurLeadersLoaded(ourLeadersModel:ourLeadersModel);
    });
  }
}
