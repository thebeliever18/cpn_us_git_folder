part of 'our_leaders_bloc.dart';

abstract class OurLeadersEvent extends Equatable {
  const OurLeadersEvent();

  @override
  List<Object?> get props => [];
}

class TriggerOurLeadersPostApi extends OurLeadersEvent{
  final OurLeadersModel ourLeadersModel;
  const TriggerOurLeadersPostApi({required this.ourLeadersModel});
  @override
  List<Object?> get props => [OurLeadersModel];
}