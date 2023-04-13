import 'package:dropandgouser/domain/onboarding/user_level_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLevelCubit extends Cubit<UserLevelInfo> {
  UserLevelCubit() : super(UserLevelInfo());

  onLevelSelected({
    required int value,
    required String title,
  }) {
    emit(state.copyWith(
      index: value,
      title: title,
    ));
  }

  dispose() {
    emit(UserLevelInfo());
  }
}
