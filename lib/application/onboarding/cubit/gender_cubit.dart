import 'package:dropandgouser/shared/enums/gender.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderCubit extends Cubit<Gender>{
  GenderCubit():super(Gender.Male);

  onRadioChanged(Gender value){
    emit(value);
  }

  dispose(){
    emit(Gender.Male);
  }

}