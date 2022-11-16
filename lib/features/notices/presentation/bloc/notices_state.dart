part of 'notices_bloc.dart';

abstract class NoticesState extends Equatable {
  const NoticesState();
  
  @override
  List<Object?> get props => [];
}

class NoticesLoading extends NoticesState {}
class NoticesInitial extends NoticesState {}

class NoticesLoaded extends NoticesState {
  final int? pageIndex;
  final NoticesModel? noticesModel;
  const NoticesLoaded({this.noticesModel,this.pageIndex});
  @override
  List<Object?> get props => [noticesModel,pageIndex];
}

class NoticesNotLoaded extends NoticesState {
  final String message;
  const NoticesNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}
