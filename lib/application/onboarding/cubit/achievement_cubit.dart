import 'package:dropandgouser/domain/onboarding/achievement_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AchievementCubit extends Cubit<AchievementInfo> {
  AchievementCubit() : super(AchievementInfo());

  onAchievementSelected({
    required int value,
    required String title,
  }) {
    emit(state.copyWith(
      index: value,
      title: title,
    ));
  }

  dispose() {
    emit(AchievementInfo());
  }
}
