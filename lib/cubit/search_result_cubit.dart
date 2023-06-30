import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picasso/cubit/search_result_state.dart';
import 'package:picasso/models/search_result_model.dart';
import 'package:picasso/respositories/api_repository.dart';

class SearchResultCubit extends Cubit<SearchResultState> {
  final APIRepository _apiRepository = APIRepository();

  SearchResultCubit() : super(InitialState());

  Future<void> getSearchResult(
      {required String query, required int page, required int perPage}) async {
    try {
      emit(LoadingState(SearchResult()));
      final response =
          await _apiRepository.fetchSearchResult(query, page, perPage);
      if (response != null) {
        final json = jsonDecode(response) as Map<String, dynamic>;
        final searchResult = SearchResult.fromJson(json);
        emit(LoadedState(searchResult));
      } else {
        emit(ErrorState());
      }
    } catch (_) {
      emit(ErrorState());
    }
  }
}
