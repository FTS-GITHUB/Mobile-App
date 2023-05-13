import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricCubit extends Cubit<bool>{
  BiometricCubit():super(true);

  initialize(bool value){
    emit(value);
  }
}
