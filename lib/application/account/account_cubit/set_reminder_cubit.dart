import 'package:flutter_bloc/flutter_bloc.dart';

class SetReminderCubit extends Cubit<bool>{
  SetReminderCubit():super(false);

  initialize(bool value){
    emit(value);
  }
}