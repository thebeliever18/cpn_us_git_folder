part of 'about_us_bloc.dart';

abstract class AboutUsEvent extends Equatable {
  const AboutUsEvent();

  @override
  List<Object?> get props => [];
}

class TriggerAboutUsPostApi extends AboutUsEvent{
  final AboutUsModel aboutUsModel;
  const TriggerAboutUsPostApi({required this.aboutUsModel});
  @override
  List<Object?> get props => [aboutUsModel];
}