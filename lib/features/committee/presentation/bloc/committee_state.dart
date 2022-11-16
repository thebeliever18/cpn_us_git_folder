part of 'committee_bloc.dart';

abstract class CommitteeState extends Equatable {
  const CommitteeState();
  
  @override
  List<Object?> get props => [];
}

class CommitteeLoading extends CommitteeState {
   final CommitteeTitleModel? committeeTitleModel;
   const CommitteeLoading({this.committeeTitleModel});
   @override
  List<Object?> get props => [committeeTitleModel];
}
class CommitteeInitial extends CommitteeState {}

class CommitteeLoaded extends CommitteeState {
  final int? pageIndex;
  final CommitteeModel? committeeModel;
  final CommitteeTitleModel? committeeTitleModel;
  const CommitteeLoaded({this.committeeModel,this.committeeTitleModel,this.pageIndex});
  @override
  List<Object?> get props => [committeeModel,committeeTitleModel,pageIndex];
}

class CommitteeNotLoaded extends CommitteeState {
  final String message;
  const CommitteeNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}

class CommitteeTitleLoading extends CommitteeState {}

class CommitteeTitleLoaded extends CommitteeState {
  
  final CommitteeTitleModel? committeeTitleModel;
  const CommitteeTitleLoaded({this.committeeTitleModel,});
  @override
  List<Object?> get props => [committeeTitleModel,];
}

class CommitteeTitleNotLoaded extends CommitteeState {
  final String message;
  const CommitteeTitleNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}
