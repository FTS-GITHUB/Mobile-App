import 'dart:async';

import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/services/i_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.authRepository,
    required this.homeRepository,
  }) : super(
          SearchStateInitial(),
        ) {
    on<FetchPreviousSearches>(_onFetchPreviousSearches);
  }

  final IAuthRepository authRepository;
  final IHomeRepository homeRepository;

  Future<void> _onFetchPreviousSearches(
      FetchPreviousSearches event, Emitter<SearchState> emit) async {
    emit(SearchStateLoading());
    if (authRepository.userId == null) {
      emit(
        SearchStateError(
          message: 'Not authorized',
        ),
      );
    } else {
      final response =await homeRepository.getPreviousSearches(userId: authRepository.userId!);
      response.fold((l) =>  emit(
        SearchStateError(
          message: l.message?? 'Failed to connect.',
        ),
      ), (r) {
        List<String> searches=[];
        if(r.isNotEmpty){
          for(var search in r){
            searches.add(search.name!);
          }
        }
        emit(SearchStateLoaded(previousSearches: searches,),);
      });

    }
  }
}
