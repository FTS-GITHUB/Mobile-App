import 'package:flutter_bloc/flutter_bloc.dart';

class FaceIdCubit extends Cubit<bool>{
  FaceIdCubit():super(true);

  initialize(bool value){
    emit(value);
  }
}
