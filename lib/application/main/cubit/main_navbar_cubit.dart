import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavBarCubit extends Cubit<int> {
  MainNavBarCubit() : super(0);
  void changeBottomNavBar(int index) => emit(index);
}
