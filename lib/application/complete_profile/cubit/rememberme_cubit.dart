import 'package:flutter_bloc/flutter_bloc.dart';

class RememberMeCubit extends Cubit<bool>{
  RememberMeCubit():super(false);

  initialize(bool value){
    emit(value);
  }
}