import 'package:flutter_bloc/flutter_bloc.dart';

class RememberMeCubit extends Cubit<bool>{
  RememberMeCubit():super(false);

  onTapped(){
    if(state){
      emit(false);
    }else{
      emit(true);
    }
  }
}