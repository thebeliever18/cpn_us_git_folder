
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:cpn_us/features/on_boarding/domain/usecases/get_on_boarding_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'on_boarding_event.dart';
part 'on_boarding_state.dart';


class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final GetOnBoardingData getOnBoardingData;


  OnBoardingBloc({required this.getOnBoardingData}) : super(OnBoardingLoading()) {
    on<TriggerOnBoardingPostApi>(_onTriggerOnBoardingPostApi);
  }

  void _onTriggerOnBoardingPostApi(
      TriggerOnBoardingPostApi event, Emitter<OnBoardingState> emit) async {
    final failureOrOnBoardingData = await getOnBoardingData(
        GetOnBoardingParams(onBoardingModel: event.onBoardingModel));
    emit(_eitherLoadedOrErrorState(failureOrOnBoardingData));
  }

  OnBoardingState _eitherLoadedOrErrorState(
      Either<Failures?, OnBoardingModel?>? failureOrOnBoardingData) {
    return failureOrOnBoardingData!.fold(
        (failure) => OnBoardingNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (onBoardingModel) {
      return OnBoardingLoaded(onBoardingModel:onBoardingModel);
    });
  }
}
