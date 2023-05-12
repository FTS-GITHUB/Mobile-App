import 'package:flutter_bloc/flutter_bloc.dart';

class RemindBedTimeCubit extends Cubit<bool>{
  RemindBedTimeCubit():super(true);

  initialize(bool value){
    emit(value);
  }
}