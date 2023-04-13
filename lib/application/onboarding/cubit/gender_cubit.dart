import 'package:dropandgouser/domain/onboarding/gender.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderCubit extends Cubit<Gender>{
  GenderCubit():super(Gender(
    index: 0,
    value: '',
  ));

  onRadioChanged(Gender gender){
    emit(state.copyWith(
      index: gender.index,
      value: gender.value,
    ));
  }

  dispose(){
    emit(Gender());
  }

}