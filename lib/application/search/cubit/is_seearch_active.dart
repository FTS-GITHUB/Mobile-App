import 'package:flutter_bloc/flutter_bloc.dart';

class IsSearchActive extends Cubit<bool>{
  IsSearchActive():super(false);

  activeSearch(){
    print(true);
    emit(true);
  }

  unActiveSearch(){
    emit(false);
  }
}