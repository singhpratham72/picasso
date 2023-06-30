import 'package:equatable/equatable.dart';
import 'package:picasso/models/search_result_model.dart';

abstract class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object?> get props => [];
}

class InitialState extends SearchResultState {}

class LoadingState extends SearchResultState {
  const LoadingState(this.searchResult);

  final SearchResult searchResult;

  @override
  List<Object?> get props => [searchResult];
}

class LoadedState extends SearchResultState {
  const LoadedState(this.searchResult);

  final SearchResult searchResult;

  @override
  List<Object?> get props => [searchResult];
}

class ErrorState extends SearchResultState {}
