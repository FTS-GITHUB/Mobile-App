part of 'home_bloc.dart';

abstract class HomeState extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeStateInitial extends HomeState{}

class HomeStateLoading extends HomeState{}

class HomeStateLoaded extends HomeState{
  HomeStateLoaded({
    required this.randomCategory,
    required this.allCategories,
    required this.recommendedCategories,
    required this.forBetterSleepCategories,
});
  final Category randomCategory;
  final List<Category> allCategories;
  final List<Category> recommendedCategories;
  final List<Category> forBetterSleepCategories;
}

class HomeStateError extends HomeState{
  HomeStateError({
    required this.message,
});
  final String message;
}
