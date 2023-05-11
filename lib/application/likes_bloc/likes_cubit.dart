import 'package:dropandgouser/domain/home/i_home_repository.dart';
import 'package:dropandgouser/domain/services/user_service.dart';
import 'package:dropandgouser/infrastructure/di/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit({
    required this.homeRepository,
  }) : super(
    LikesStateInitial(),
  );
  final IHomeRepository homeRepository;

  Future<void> likeCategory({
    required String categoryId,
  }) async {
    final userData = getIt<UserService>().userData;
    if (userData?.id == null) {
      emit(LikesStateError(message: 'Failed to connect',),);
    }else{
      emit(LikesStateLoading());
      final response = await homeRepository.likeCategory(
        categoryId: categoryId,
        userId: userData!.id!,
      );
      response.fold(
            (l) => emit(LikesStateError(message: l.message ?? '')),
            (r) {
              getIt<UserService>().userData = r;
              emit(
              LikesStateLoaded(
                userData: r,
              ),
            );
            },
      );
    }
  }
}
