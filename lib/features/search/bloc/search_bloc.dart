
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<OnSearch>(_onSearch);
    on<OnSearchClose>(_onSearchClose);
  }

  void _onSearch(OnSearch event, Emitter<SearchState> emit) {
    emit(SearchLoaded(event.searchValue??""));
  }

  void _onSearchClose(OnSearchClose event, Emitter<SearchState> emit) {
    emit(SearchInitial(searchValue:event.searchValue));
  }
}
