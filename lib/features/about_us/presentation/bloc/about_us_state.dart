part of 'about_us_bloc.dart';

abstract class AboutUsState extends Equatable {
  const AboutUsState();
  
  @override
  List<Object?> get props => [];
}

class AboutUsLoading extends AboutUsState {}
class AboutUsInitial extends AboutUsState {}

class AboutUsLoaded extends AboutUsState {
  final int? pageIndex;
  final AboutUsModel? aboutUsModel;
  const AboutUsLoaded({this.aboutUsModel,this.pageIndex});
  @override
  List<Object?> get props => [aboutUsModel,pageIndex];
}

class AboutUsNotLoaded extends AboutUsState {
  final String message;
  const AboutUsNotLoaded({required this.message});
   @override
  List<Object?> get props => [message];
}
