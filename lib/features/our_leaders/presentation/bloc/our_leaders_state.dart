part of 'our_leaders_bloc.dart';

abstract class OurLeadersState extends Equatable {
  const OurLeadersState();
  
  @override
  List<Object?> get props => [];
}

class OurLeadersLoading extends OurLeadersState {}
class OurLeadersInitial extends OurLeadersState {}

class OurLeadersLoaded extends OurLeadersState {
  final int? pageIndex;
  final OurLeadersModel? ourLeadersModel;
  const OurLeadersLoaded({this.ourLeadersModel,this.pageIndex});
  @override
  List<Object?> get props => [OurLeadersModel,pageIndex];
}

class OurLeadersNotLoaded extends OurLeadersState {
  final String message;
  const OurLeadersNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}
