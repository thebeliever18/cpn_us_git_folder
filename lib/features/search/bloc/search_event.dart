part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


class OnSearch extends SearchEvent {
  final String? searchValue;
  OnSearch({this.searchValue});
  @override
  List<Object> get props => [searchValue!];
}

class OnSearchClose extends SearchEvent {
final String? searchValue;
  OnSearchClose({this.searchValue});
  @override
  List<Object> get props => [searchValue!];
}