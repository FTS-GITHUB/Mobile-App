import 'package:flutter_bloc/flutter_bloc.dart';

class DobDateCubit extends Cubit<DateTime> {
  DobDateCubit()
      : super(
          DateTime.now(),
        );

  onDateSelected(DateTime? dateTime){
    if(dateTime!=null){
      emit(dateTime);
    }
  }

  dispose(){
    emit(DateTime.now());
  }
}
