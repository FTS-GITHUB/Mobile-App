import 'package:flutter_bloc/flutter_bloc.dart';

class LoginObscurePasswordCubit extends Cubit<bool>{
  LoginObscurePasswordCubit():super(true);

  onTapped(){
    if(state){
      emit(false);
    }else{
      emit(true);
    }
  }

}