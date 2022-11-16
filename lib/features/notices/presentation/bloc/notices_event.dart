part of 'notices_bloc.dart';

abstract class NoticesEvent extends Equatable {
  const NoticesEvent();

  @override
  List<Object?> get props => [];
}

class TriggerNoticesPostApi extends NoticesEvent{
  final NoticesModel noticesModel;
  const TriggerNoticesPostApi({required this.noticesModel});
  @override
  List<Object?> get props => [noticesModel];
}