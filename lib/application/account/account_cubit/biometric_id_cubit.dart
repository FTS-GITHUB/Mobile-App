import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricCubit extends Cubit<bool>{
  BiometricCubit():super(true);

  initialize(bool value){
    SharedPreferenceHelper.isBiometricEnabled = value;
    emit(value);
  }
}
