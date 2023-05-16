import 'package:dropandgouser/domain/account/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferenceCubit extends Cubit<Preference> {
  PreferenceCubit() : super(Preference());

  initialize(Preference preference) {
    emit(preference);
  }

  changeDownloadOverWifi(bool value) {
    emit(state.copyWith(downloadWifi: value));
  }

  changeAudioQuality(String value) {
    emit(
      state.copyWith(
        audioQuality: value,
      ),
    );
  }
}
