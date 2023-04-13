import 'package:dropandgouser/domain/onboarding/age.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeCubit extends Cubit<Age> {
  AgeCubit() : super(Age());

  onAgeChanged(int index, {required String value}) {
    emit(state.copyWith(
      index: index,
      value: value,
    ));
  }

  dispose() {
    emit(
      Age(),
    );
  }
}
