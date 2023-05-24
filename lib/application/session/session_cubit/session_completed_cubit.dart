import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCompletedCubit extends Cubit<bool>{
  SessionCompletedCubit():super(false);

  initialize(bool value){
    emit(value);
  }
}