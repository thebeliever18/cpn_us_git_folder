
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'landing_event.dart';
part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingInitial()) {
    on<OnDrawerItemClicked>(_onIndexChanged);
  }

  void _onIndexChanged(OnDrawerItemClicked event, Emitter<LandingState> emit) {
    emit(LandingIndexChanged(index: event.index,activate: event.activate,appBarTitle: event.appBarTitle));
  }
}
