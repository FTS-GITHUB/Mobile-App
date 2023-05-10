import 'dart:async';

import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_found_event.dart';

part 'search_found_state.dart';

class SearchFoundBloc extends Bloc<SearchEvent, SearchFoundState> {
  SearchFoundBloc({
    required this.homeRepository,
})
      : super(
          SearchFoundStateInitial(),
        ) {
    on<FetchSearch>(_onFetchSearch);
    on<AddSearchToPrevious>(_onAddSearchToPrevious);
  }

  final IHomeRepository homeRepository;

  Future<void> _onFetchSearch(
      FetchSearch event, Emitter<SearchFoundState> emit) async {
    if (event.searchText.isEmpty) {
      emit(SearchFoundStateInitial());
    } else {
      emit(SearchFoundStateLoading());
      List<Category> tempCategories = [];
      // print(event.searchText);
      for (var category in event.categories) {
        // print(category.name);
        if (category.name != null &&
            category.name!.toLowerCase().contains(
                  event.searchText.toLowerCase(),
                )) {
          tempCategories.add(category);
        }
      }
      add(
        AddSearchToPrevious(
          categories: tempCategories,
          searchText: event.searchText,
        ),
      );
    }
  }

  Future<void> _onAddSearchToPrevious(
      AddSearchToPrevious event, Emitter<SearchFoundState> emit) async {
    final user = getIt<UserService>().userData;
    if (user?.id == null) {
      emit(
        SearchFoundStateError(
          message: 'Please sign in again to search',
        ),
      );
    } else {
      final response = await homeRepository.uploadNewSearch(
        userId: user!.id!,
        searchText: event.searchText,
      );
      response.fold(
          (l) => emit(
              SearchFoundStateError(message: l.message ?? "Failed to connect")),
          (r) {
        emit(
          SearchFoundStateLoaded(categories: event.categories),
        );
      });
    }
  }
}
