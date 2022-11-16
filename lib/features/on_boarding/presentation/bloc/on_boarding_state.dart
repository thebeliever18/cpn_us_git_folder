part of 'on_boarding_bloc.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();
  
  @override
  List<Object?> get props => [];
}

class OnBoardingLoading extends OnBoardingState {}
class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoaded extends OnBoardingState {
  final int? pageIndex;
  final OnBoardingModel? onBoardingModel;
  const OnBoardingLoaded({this.onBoardingModel,this.pageIndex});
  @override
  List<Object?> get props => [onBoardingModel,pageIndex];
}

class OnBoardingNotLoaded extends OnBoardingState {
  final String message;
  const OnBoardingNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}
