part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
   final String? searchValue;
  SearchInitial({this.searchValue});
  @override
  List<Object> get props => [searchValue!];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
   final String searchValue;
  SearchLoaded(this.searchValue);
  @override
  List<Object> get props => [searchValue];
}

class SearchNotLoaded extends SearchState {
  @override
  List<Object> get props => [];
}
