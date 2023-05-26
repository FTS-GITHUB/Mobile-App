import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadProgressCubit extends Cubit<int>{
  DownloadProgressCubit():super(0);

  updateDownloadProgress(int progress){
    emit(progress);
  }

  reset(){
    emit(0);
  }

}