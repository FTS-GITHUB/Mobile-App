import 'package:dropandgouser/shared/enums/age.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeCubit extends Cubit<AgeRange>{
  AgeCubit():super(AgeRange.Age18To29);

  onAgeChanged(AgeRange value){
    emit(value);
  }

  dispose(){
    emit(AgeRange.Age18To29);
  }

}