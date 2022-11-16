
import 'package:cpn_us/core/error/failures.dart';
import 'package:cpn_us/core/error/map_failures_to_message.dart';
import 'package:cpn_us/features/about_us/data/models/about_us_model.dart';
import 'package:cpn_us/features/about_us/domain/usecases/get_about_us_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'about_us_event.dart';
part 'about_us_state.dart';


class AboutUsBloc extends Bloc<AboutUsEvent, AboutUsState> {
  final GetAboutUsData getAboutUsData;


  AboutUsBloc({required this.getAboutUsData}) : super(AboutUsLoading()) {
    on<TriggerAboutUsPostApi>(_onTriggerAboutUsPostApi);
  }

  void _onTriggerAboutUsPostApi(
      TriggerAboutUsPostApi event, Emitter<AboutUsState> emit) async {
    final failureOrAboutUsData = await getAboutUsData(
        GetAboutUsParams(aboutUsModel: event.aboutUsModel));
    emit(_eitherLoadedOrErrorState(failureOrAboutUsData));
  }

  AboutUsState _eitherLoadedOrErrorState(
      Either<Failures?, AboutUsModel?>? failureOrAboutUsData) {
    return failureOrAboutUsData!.fold(
        (failure) => AboutUsNotLoaded(
            message:
                MapFailuresToMessage.mapFailureToMessage(failure: failure)),
        (aboutUsModel) {
      return AboutUsLoaded(aboutUsModel:aboutUsModel);
    });
  }
}
