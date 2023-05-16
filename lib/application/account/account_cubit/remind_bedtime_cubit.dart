import 'package:dropandgouser/shared/helpers/shared_preferences_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemindBedTimeCubit extends Cubit<bool>{
  RemindBedTimeCubit():super(true);

  initialize(bool value){
    SharedPreferenceHelper.isRemindAtBedtime = value;
    emit(value);
  }
}