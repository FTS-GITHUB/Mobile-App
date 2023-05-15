import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaceIdCubit extends Cubit<bool>{
  FaceIdCubit():super(true);

  initialize(bool value){
    SharedPreferenceHelper.isBiometricEnabled = value;
    emit(value);
  }
}
