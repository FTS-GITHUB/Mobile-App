import 'dart:async';
import 'dart:math';

import 'package:dropandgouser/domain/home/category.dart';
import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.homeRepository,
  }) : super(HomeStateInitial()) {
    on<FetchCategories>(_onFetchCategories);
  }

  final IHomeRepository homeRepository;

  Future<void> _onFetchCategories(
    FetchCategories event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeStateLoading());
    final response = await homeRepository.getCategories();
    response.fold(
        (l) => emit(HomeStateError(
              message: l.message ?? "Failed to connect",
            )), (List<Category> categories) {
          print('Categories ${categories.length}');
      List<Category>? recommendedCategories = <Category>[];
      List<Category> forBetterSleepCategories = <Category>[];
      late Category randomCategory;
      recommendedCategories =
          categories.where((category) => category.isRecommended!).toList();
      forBetterSleepCategories = (categories.toList()..shuffle()).toList();
      if(categories.isNotEmpty){
        randomCategory =  (categories[Random().nextInt(categories.length)]);
      }else{
        randomCategory = Category();
      }
      print(randomCategory.toJson());
      emit(
        HomeStateLoaded(
          randomCategory: randomCategory,
          allCategories: categories,
          recommendedCategories: recommendedCategories,
          forBetterSleepCategories: forBetterSleepCategories,
        ),
      );
    });
  }
}
