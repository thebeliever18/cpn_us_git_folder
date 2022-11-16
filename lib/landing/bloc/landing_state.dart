part of 'landing_bloc.dart';

abstract class LandingState extends Equatable {
  const LandingState();
  
  @override
  List<Object> get props => [];
}

class LandingInitial extends LandingState {}

class LandingIndexChanged extends LandingState {
  final int index;
  final bool activate;
  final String appBarTitle;
  LandingIndexChanged({required this.index,required this.activate,required this.appBarTitle});
  @override
  List<Object> get props => [index,activate,appBarTitle];
}