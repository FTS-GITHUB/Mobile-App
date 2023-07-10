import 'package:bloc/bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordCubitState> {
  ChangePasswordCubit() : super(ChangePasswordCubitState());

  onOldPasswordTapped() {
    if (state.isOldPasswordObscure) {
      emit(
        state.copyWith(
          isOldPasswordObscure: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isOldPasswordObscure: true,
        ),
      );
    }
  }

  onNewPasswordTapped() {
    if (state.isNewPasswordObscure) {
      emit(
        state.copyWith(
          isNewPasswordObscure: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isNewPasswordObscure: true,
        ),
      );
    }
  }

  onConfirmNewPasswordTapped() {
    if (state.isConfirmNewPasswordObscure) {
      emit(
        state.copyWith(
          isConfirmNewPasswordObscure: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isConfirmNewPasswordObscure: true,
        ),
      );
    }
  }
}
