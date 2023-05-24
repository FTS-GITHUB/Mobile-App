import 'dart:async';

import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/search/previous_searches.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.homeRepository,
  }) : super(
          SearchStateInitial(),
        ) {
    on<FetchPreviousSearches>(_onFetchPreviousSearches);
    on<DeleteSearch>(_onDeleteSearch);
  }

  final IHomeRepository homeRepository;

  Future<void> _onFetchPreviousSearches(
      FetchPreviousSearches event, Emitter<SearchState> emit) async {
    final user = getIt<UserService>().userData;
    emit(SearchStateLoading());
    if (user?.id == null) {
      emit(
        SearchStateError(
          message: 'Not authorized',
        ),
      );
    } else {
      final response = await homeRepository.getPreviousSearches(
          userId: user!.id!);
      response.fold(
          (l) => emit(
                SearchStateError(
                  message: l.message ?? 'Failed to connect.',
                ),
              ), (r) {
        List<PreviousSearches> searches = [];
        if (r.isNotEmpty) {
          for (var search in r) {
            searches.add(search);
          }
        }
        emit(
          SearchStateLoaded(
            previousSearches: searches,
          ),
        );
      });
    }
  }

  Future<void> _onDeleteSearch(
      DeleteSearch event, Emitter<SearchState> emit) async {
    final user = getIt<UserService>().userData;
    emit(SearchStateLoading());
    if (user?.id == null) {
      emit(
        SearchStateError(
          message: 'Not authorized',
        ),
      );
    } else {
      final response = await homeRepository.deleteSearch(
        userId: user!.id!,
        docId: event.docId,
      );
      response.fold(
        (l) =>
            emit(SearchStateError(message: l.message ?? "Failed to connect")),
        (r) => add(
          FetchPreviousSearches(),
        ),
      );
    }
  }
}
