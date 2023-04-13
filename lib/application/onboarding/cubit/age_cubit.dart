import 'package:dropandgouser/domain/onboarding/age.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeCubit extends Cubit<Age> {
  AgeCubit() : super(Age());

  onAgeChanged(Age age) {
    emit(state.copyWith(
      index: age.index,
      value: age.value,
    ));
  }

  dispose() {
    emit(
      Age(),
    );
  }
}
