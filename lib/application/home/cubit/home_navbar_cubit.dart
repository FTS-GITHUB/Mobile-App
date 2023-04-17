import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavBarCubit extends Cubit<int> {
  HomeNavBarCubit() : super(0);
  void changeBottomNavBar(int index) => emit(index);
}
