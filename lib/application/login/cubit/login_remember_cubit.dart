import 'package:flutter_bloc/flutter_bloc.dart';

class LoginRememberCubit extends Cubit<bool>{
  LoginRememberCubit():super(false);

  onTapped(){
    if(state){
      emit(false);
    }else{
      emit(true);
    }
  }
}