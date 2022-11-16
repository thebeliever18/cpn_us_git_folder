part of 'on_boarding_bloc.dart';

abstract class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object?> get props => [];
}

class TriggerOnBoardingPostApi extends OnBoardingEvent{
  final OnBoardingModel onBoardingModel;
  const TriggerOnBoardingPostApi({required this.onBoardingModel});
  @override
  List<Object?> get props => [onBoardingModel];
}