part of 'committee_bloc.dart';

abstract class CommitteeEvent extends Equatable {
  const CommitteeEvent();

  @override
  List<Object?> get props => [];
}

class TriggerCommitteePostApi extends CommitteeEvent{
  final CommitteeModel committeeModel;
  const TriggerCommitteePostApi({required this.committeeModel});
  @override
  List<Object?> get props => [committeeModel];
}

class GetCommitteeTitle extends CommitteeEvent{
  final CommitteeTitleModel committeeTitleModel;
  const GetCommitteeTitle({required this.committeeTitleModel});
  @override
  List<Object?> get props => [committeeTitleModel];
}