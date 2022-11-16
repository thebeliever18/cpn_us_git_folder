part of 'landing_bloc.dart';

abstract class LandingEvent extends Equatable {
  const LandingEvent();

  @override
  List<Object> get props => [];
}


class OnDrawerItemClicked extends LandingEvent{
  final int index;
  final bool activate;
  final String appBarTitle;
  OnDrawerItemClicked({required this.index,required this.activate,required this.appBarTitle});
  @override
  List<Object> get props => [index,activate,appBarTitle];
}
